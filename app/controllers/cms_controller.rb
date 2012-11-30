class CmsController < ApplicationController

  def create
    attribute = params[:attribute].to_sym
    edited_text = params[:edited_text]
    page = params[:page]
    cms_model = get_correct_model(page)
    cms_model.update_attributes( attribute => edited_text )

    if page == "layout" 
      redirect_to root_path
    else
      redirect_to "/#{page}" 
    end
  end

  private

  def get_correct_model(page)
    case
    when page == "layout"
      return CmsLayout.first
    when page == "home"
      return CmsHome.first
    when page == "about"
      return CmsAbout.first
    when page == "testimonials"
      return CmsTestimonials.first
    when page == "gallery"
      return CmsGallery.first
    when page == "contact"
      return CmsContact.first
    end
  end
end