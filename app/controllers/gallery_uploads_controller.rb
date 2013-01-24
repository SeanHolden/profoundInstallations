require 'fileutils'

class GalleryUploadsController < ApplicationController
  layout 'dashboard', :only => [:index]

  def create
    images      = params[:file_upload][:my_files]
    album_title = params[:file_upload][:title]
    slug = album_title.downcase.strip.gsub(' ', '_').gsub(/[^\w-]/, '')
    album = Album.new(:title => album_title, :slug=>slug)
    if check_images_are_valid(images) == true
      album.save
      gallery_id = album.id
      directory_location = "public/assets/workexamples/#{slug}"
      FileUtils.mkdir directory_location
      upload_images(images, directory_location, gallery_id)
      cover_image = Image.find_by_gallery_id(gallery_id).file_location
      album.update_attributes(:cover_image=>cover_image)
      redirect_to gallery_uploads_path, :notice => 'Successfully uploaded image'
    else
      redirect_to gallery_uploads_path, :alert => 'Something went wrong. Album not saved.'
    end
  end

  private

  def check_images_are_valid(images)
    valid_extensions = ['jpg','jpeg','png','gif']
    images.each do |image|
      return false unless image.original_filename.include?('.')
      extension = image.original_filename.split('.')[1]
      extension = extension.downcase
      return false unless valid_extensions.include?(extension)
    end
    return true
  end
  
  def upload_images(images, directory_location, gallery_id)
    images.each do |image|
      tmp = image.tempfile
      file = File.join(directory_location, image.original_filename)
      FileUtils.cp tmp.path, file
      sliced_location = directory_location.gsub('public/assets/','')
      Image.create(:gallery_id=>gallery_id, :file_location=>sliced_location+'/'+image.original_filename)
    end
  end
end