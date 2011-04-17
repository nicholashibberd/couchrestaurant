class ImageUnit < Unit  
  property :filename
  property :slug
  property :site
  
  def delete_file
    image_file = Rails.root.join('public', 'images', "#{self.site}", "#{self.slug}", "#{self.filename}.jpeg")
    FileUtils.rm(image_file)
  end
end  
