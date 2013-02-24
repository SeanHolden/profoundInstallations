class AboutController < ApplicationController
  before_filter :authenticate_admin!
  layout 'dashboard'

  # GET
  def index
  	@about = About.first
  end

  # GET /about/:id/edit
  def edit
  	@about = About.first
  end

  # PUT
  def update
   	body = params[:body]
  	About.first.update_attributes(:body=> body)
  	redirect_to about_index_path, :notice => 'Successfully updated About page.'
  end
end
