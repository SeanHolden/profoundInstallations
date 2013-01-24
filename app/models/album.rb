class Album < ActiveRecord::Base
  attr_accessible :title, :cover_image, :slug
end
