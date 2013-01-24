require 'fileutils'

class GalleryUploadsController < ApplicationController
  layout 'dashboard', :only => [:index]

  def create
    images      = params[:file_upload][:my_files]
    album_title = params[:file_upload][:title]
    slug = album_title.downcase.strip.gsub(' ', '_').gsub(/[^\w-]/, '')
    album = Album.new(:title => album_title, :slug=>slug)
    if album.save
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
  
  def upload_images(images, directory_location, gallery_id)
    images = params[:file_upload][:my_files]
    images.each do |image|
      tmp = image.tempfile
      file = File.join(directory_location, image.original_filename)
      FileUtils.cp tmp.path, file
      sliced_location = directory_location.gsub('public/assets/','')
      Image.create(:gallery_id=>gallery_id, :file_location=>sliced_location+'/'+image.original_filename)
    end
  end
end


# TABLES:

# Images

# ID,   GALLERY_ID,   FILE_LOCATION
# 1     1             '/workexamples/EPDM_Flat_roof1'
# 2     1             '/workexamples/EPDM_Flat_roof2'
# 3     1             '/workexamples/EPDM_Flat_roof3'
# 4     2             '/workexamples/Wood_Grain_Back_Door1'
# 5     2             '/workexamples/Wood_Grain_Back_Door2'


# Album

# ID     TITLE
# 1      Flat roof
# 2      Back door