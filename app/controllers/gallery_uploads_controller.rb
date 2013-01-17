require 'fileutils'

class GalleryUploadsController < ApplicationController
  layout 'dashboard', :only => [:index]

  def create
    tmp = params[:file_upload][:my_file].tempfile
    file = File.join("public", params[:file_upload][:my_file].original_filename)
    FileUtils.cp tmp.path, file

    redirect_to gallery_uploads_path, :notice => 'Successfully uploaded image'
  end
end


# TODO make these tables:

# TABLES:

# Images

# ID,   GALLERY_ID,   FILE_LOCATION
# 1     1             '/workexamples/EPDM_Flat_roof1'
# 2     1             '/workexamples/EPDM_Flat_roof2'
# 3     1             '/workexamples/EPDM_Flat_roof3'
# 4     2             '/workexamples/Wood_Grain_Back_Door1'
# 5     2             '/workexamples/Wood_Grain_Back_Door2'


# Album

# ID     NAME                    TITLE        ALBUM_COVER
# 1      EPDM_Flat_Roof           Flat roof   '/album_covers/EPDM_Flat_Roof'
# 2      Wood_Grain_Back_Door     Back door   '/album_covers/Wood_Grain_Back_Door'