class Testimonial < ActiveRecord::Base
  attr_accessible :body, :name

  validates_presence_of :body, :name
end
