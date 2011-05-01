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
  
  def url_for_page(page, action)
    if page.has_parent?
      child_page_path(:id => page.parent_slug, :sub_id => page.slug)
    else
      page_path(page)
    end
  end

  def url_for_page_edit(page)
    if page.has_parent?
      edit_child_page_path(:id => page.parent_slug, :sub_id => page.slug)
    else
      edit_page_path(page)
    end
  end
  
  def display_new_page_link(page, &block)  
    content_tag(:div, nil, &block) if !page.has_parent?
  end
  
  
    
end
