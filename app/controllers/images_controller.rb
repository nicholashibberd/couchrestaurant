class ImagesController < ApplicationController

  MAX_WIDTH = 990.0
  MAX_HEIGHT = 687.0

  def create
    attachment_param = params[:attachment]
    image_type = params[:image_type]
    new_filename = params[:file_name]
    site = params[:site]
    slug = params[:slug]
    create_image(attachment_param, new_filename, site, slug, image_type)

    page = @site.find_page(slug)
    
    #Create new image unit
    if image_type == 'unit'
      page.add_element('image', {:site => site, :slug => slug, :filename => new_filename})
    
    #Create new background image
    elsif image_type == 'background'
      page.add_background_image(:site => site, :slug => slug, :filename => new_filename)
    end
    
    redirect_to :controller => 'pages', :action => 'edit', :id => slug
  end

  def create_image(attachment_param, new_filename, site, slug, image_type)
    if attachment_param.nil?
      flash[:message] = "No image selected to upload"
    else
      filename = File.basename(attachment_param.original_filename)
      
      if image_type == 'unit'
        resized_filename = Rails.root.join('public','images', "#{site}", "#{slug}", "#{new_filename}.jpeg")
        target_directory = Rails.root.join('public','images', "#{site}", "#{slug}")
      elsif image_type == 'background'
        resized_filename = Rails.root.join('public','images', "#{site}", "#{slug}", "backgrounds", "#{new_filename}.jpeg")
        target_directory = Rails.root.join('public','images', "#{site}", "#{slug}", "backgrounds")
      end

      if !File.directory?(target_directory)
        FileUtils.mkpath(target_directory)
      end

      original = MiniMagick::Image.read(attachment_param.read)

      img_width, img_height = original['%w %h'].split
      img_width = img_width.to_f
      img_height = img_height.to_f

      if img_width > MAX_WIDTH or img_height > MAX_HEIGHT
        # Need to resize
        if (img_width/img_height) > (MAX_WIDTH/MAX_HEIGHT)
          # Image is wider in proportion than the space
          percentage = (MAX_WIDTH * 100.0) / img_width
        else
          # Image is taller in proportion than the space
          percentage = (MAX_HEIGHT * 100.0) / img_height
        end
        original.resize "#{percentage}%"
      end
      original.write resized_filename
      File.new(resized_filename).chmod(0644) 
    end
  end
  
  def destroy
    page = @site.find_page(params[:id])
    image = page.background_images.select {|img| img['filename'] == params[:filename]}[0]
    image_file = Rails.root.join('public', 'images', "#{@site.theme}", "#{image.slug}", "backgrounds", "#{image.filename}.jpeg")
    value = page.background_images.index(image)
    page.background_images.delete_at(Integer(value))
    page.save
    FileUtils.rm(image_file)
    redirect_to :controller => 'pages', :action => 'edit', :id => params[:id]
    
  end
end