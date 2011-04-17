class MenuSectionsController < ApplicationController
  layout 'admin'
  
  def new
    @menu = @site.find_menu(params[:menu_id])
    if params[:content_type] == 'dish'
      @dish = Dish.new
    end
  end
  
  
  def edit
    menu = @site.find_menu(params[:menu_id])
    unit_number = Integer(params[:id])
    @menu_section = menu.menu_sections[unit_number]

  end
  
  def update_menu_section
    raise params.inspect
  end
  
  def create_menu_section
    menu = @site.find_menu(params[:menu_id])
    menu.add_section(params['content_type'], params[:menu_section])
    redirect_to :controller => 'menus', :action => 'edit', :id => menu.slug 
  end
end