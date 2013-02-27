class ImageUploadsController < ApplicationController
  before_filter :authenticate_admin!

  def create
    images = assign_images(params[:file_upload])
    gallery_id = params[:gallery_id]
    album = Album.find(gallery_id)
    directory_name = album.slug
    directory_location = "public/assets/workexamples/#{directory_name}"
    if Image.check_images_are_valid(images) == true
      Image.upload_images(images, directory_location, gallery_id)
      redirect_to edit_gallery_upload_path(album.id), :notice => 'Successfully added images to album.'
    else
      redirect_to edit_gallery_upload_path(album.id), :alert => 'Something went wrong. Images must be jpg, png or gif format.'
    end
  end

  def destroy
    id = params[:id]
    image = Image.find(id).destroy
    FileUtils.rm("#{Rails.root}/public/#{image.file_location}")
    redirect_to edit_gallery_upload_path(image.gallery_id)
  end

  def update
    image_id = params[:image_id]
    gallery_id = params[:gallery_id]
    album = Album.find(gallery_id)
    image = Image.find(image_id)
    album.update_attributes(:cover_image => image.file_location)
    redirect_to edit_gallery_upload_path(image.gallery_id)
  end

  private

  def assign_images(files)
    if files.nil?
      return nil
    else
      return files[:my_files]
    end
  end
end