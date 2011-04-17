module PagesHelper
  
  def render_menu_view
    @menu = @page.menu 
  end  

  def image_upload(image_type)
    case image_type
      when 'background' then render :partial => 'admin/image_upload', :locals => {:image_type => 'background'}
      when 'unit' then render :partial => 'admin/image_upload', :locals => {:image_type => 'unit'}
    end
  end
    
end
