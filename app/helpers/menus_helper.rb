module MenusHelper
  
  def menu_section(section)
    render :partial => 'menus/menu_section', :locals => {:section => section}
  end
end