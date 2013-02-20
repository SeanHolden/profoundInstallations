class HomeController < ApplicationController
  def index
  end

  def about
    @about_text = About.first.body
  end

  def testimonials
    @testimonials = Testimonial.all
  end

  def messagesent
  end

  def gallery
    @albums = Album.all
  end

  # GET /gallery/:gallery_url
  def gallery_album
    slug = params[:gallery_url]
    gallery_id = Album.find_by_slug(slug).id
    @images = Image.where(:gallery_id=>gallery_id)
  end

end
