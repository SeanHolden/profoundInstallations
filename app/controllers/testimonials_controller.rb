class TestimonialsController < ApplicationController
  before_filter :authenticate_admin!

  layout 'dashboard', :only => [:index, :new, :edit]
  
  # GET /testimonials
  def index
  	@testimonials = Testimonial.all
  end

  # GET /testimonials/new
  def new
  end

  # GET /testimonials/:id/edit
  def edit
  	testimonial_id = params[:id]
  	@testimonial = Testimonial.find(testimonial_id)
  end

  # PUT /testimonials/:id
  def update
  	testimonial_id = params[:id]
  	new_name = params[:name]
  	new_body = params[:body]
  	testimonial = Testimonial.update( testimonial_id, :name=> new_name, :body => new_body )
  	if testimonial.save
      redirect_to testimonials_path, :notice => "Successfully updated testimonial."
  	else
      redirect_to testimonials_path, :alert => "Something went wrong. Did you include both a name and message?"
  	end
  end

  # POST /testimonials
  def create
  	name = params[:name]
  	body = params[:body]
  	testimonial = Testimonial.new(name: name, body: body)
  	if testimonial.save
      redirect_to testimonials_path, :notice => "Successfully added testimonial from #{name}."
    else
      redirect_to testimonials_path, :notice => "Something went wrong. Did you include both a name and message?"
  	end
  end

  # DELETE /testimonials/:id
  def destroy
  	testimonial_id = params[:id]
  	Testimonial.find(testimonial_id).destroy
  	redirect_to testimonials_path, :notice => 'Successfully deleted testimonial.'
  end

end