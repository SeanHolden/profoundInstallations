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
      # directory_location = "public/assets/workexamples/#{slug}"
      directory_location = "public/images/albums/#{slug}"
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
    FileUtils.rm_rf("public/images/albums/#{album.slug}")
    redirect_to gallery_uploads_path, :notice => 'Successfully deleted album'
  end

  def edit
    id = params[:id]
    @album = Album.find(id)
    @images = Image.where(:gallery_id=>id)
  end

end