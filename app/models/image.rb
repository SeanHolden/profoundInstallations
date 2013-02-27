class Image < ActiveRecord::Base
  attr_accessible :file_location, :gallery_id

  private

  def self.check_images_are_valid(images)
    valid_extensions = ['jpg','jpeg','png','gif']
    return false if images.nil?
    images.each do |image|
      return false unless image.original_filename.include?('.')
      extension = image.original_filename.split('.')[1]
      extension = extension.downcase
      return false unless valid_extensions.include?(extension)
    end
    return true
  end

  def self.upload_images(images, directory_location, gallery_id)
    images.each do |image|
      filename = Image.check_if_image_exists(image, gallery_id, directory_location)
      tmp = image.tempfile
      file = File.join(directory_location, filename)
      FileUtils.cp tmp.path, file
      sliced_location = directory_location.gsub("public","")
      Image.create!(:gallery_id=>gallery_id, :file_location=>sliced_location+'/'+filename)
    end
  end

  def self.check_if_image_exists(image, gallery_id, directory_location)
    sliced_location = directory_location.gsub('public','')
    filename = image.original_filename.split('.')
    file_location = sliced_location+'/'+filename[0]
    file_exists = Image.where("file_location REGEXP '#{file_location}' AND gallery_id = #{gallery_id}")
    if file_exists.count > 0
      return "#{filename[0]}_#{file_exists.count.to_s}.#{filename[1]}"
    else
      return image.original_filename
    end
  end
end