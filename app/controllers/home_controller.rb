class HomeController < ApplicationController
  def index
  end

  def about
  end

  def testimonials
  end

  def messagesent
  end

  def gallery
    @albums = Album.all
  end

  # GET /gallery/:nameofdirectory
  def gallery_album
    @album = params[:nameofdirectory]
    @number_of_images = Album.display(@album).count
  end

end
