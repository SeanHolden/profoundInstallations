require 'fileutils'

class GalleryUploadsController < ApplicationController
  before_filter :authenticate_admin!
  layout 'dashboard', :only => [:index, :new, :edit]

  def index
    @albums = Album.all
  end

  def create
    images      = params[:file_upload][:my_files]
    album_title = params[:file_upload][:title]
    slug = album_title.downcase.strip.gsub(' ', '_').gsub(/[^\w-]/, '')
    album = Album.new(:title => album_title, :slug=>slug)
    if Image.check_images_are_valid(images) == true && album_title != ''
      album.save
      gallery_id = album.id
      directory_location = "#{APP_CONFIG[Rails.env]['upload_images_path']}/images/albums/#{slug}"
      FileUtils.mkdir directory_location
      Image.upload_images(images, directory_location, gallery_id)
      cover_image = Image.find_by_gallery_id(gallery_id).file_location
      album.update_attributes(:cover_image=>cover_image)
      redirect_to gallery_uploads_path, :notice => 'Successfully created album'
    else
      redirect_to gallery_uploads_path, :alert => 'Something went wrong. Album not saved.'
    end
  end

  def destroy
    id = params[:id]
    album = Album.find(id).destroy
    # Destroy all images that were inside this album.
    Image.where(gallery_id: id).destroy_all
    FileUtils.rm_rf("#{APP_CONFIG[Rails.env]['upload_images_path']}/images/albums/#{album.slug}")
    redirect_to gallery_uploads_path, :notice => 'Successfully deleted album'
  end

  # Update album title in database, including locations and changing directory name
  def update
    id = params[:id]
    album = Album.find(id)
    title = params[:title]
    old_slug = album.slug
    new_slug = title.downcase.strip.gsub(' ', '_').gsub(/[^\w-]/, '')
    new_cover_image = album.cover_image.gsub(old_slug,new_slug)
    album.update_attributes(:title=>title, :slug=>new_slug, :cover_image=>new_cover_image)
    Image.where(gallery_id: id).each do |image|
      new_file_location = image.file_location.gsub(old_slug,new_slug)
      image.update_attributes(:file_location=>new_file_location)
    end
    dir = "#{APP_CONFIG[Rails.env]['upload_images_path']}/images/albums/"
    FileUtils.mv("#{dir}#{old_slug}", "#{dir}#{new_slug}")
    redirect_to edit_gallery_upload_path(id)
  end

  def edit
    id = params[:id]
    @album = Album.find(id)
    @images = Image.where(:gallery_id=>id)
  end

end