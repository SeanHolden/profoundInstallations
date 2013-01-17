class DashboardController < ApplicationController
  layout 'dashboard', :only => :index

  def index
    @message = "hello"
  end

  # GET gallery
  def gallery
    require 'fileutils'
    puts params
    # tmp = params[:gallery][:my_file].tempfile
    # File.join("public", params[:gallery][:my_file].original_filename)
    # FileUtils.cp tmp.path, file
    # # YOUR PARSING JOB
    # FileUtils.rm file

  end

end
