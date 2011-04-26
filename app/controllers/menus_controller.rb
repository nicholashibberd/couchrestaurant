class MenusController < ApplicationController
  layout 'admin'

  def new
    @menu = Menu.new
  end
  
  def index
    @menus = @site.menus
  end
  
  def edit
    @menu = @site.find_menu(params[:id])
  end
  
  def show
    
  end
  
  def create
    menu = Menu.new(params[:menu])
    if menu.save!
      redirect_to admin_path
    else
      raise "Menu did not save"
    end
  end

  def update
    menu = @site.find_menu(params[:menu][:slug])
    menu.update_attributes(params[:menu])
    if params[:commit] == 'Add price category'
      menu.add_price_category(params[:add_price_category])
    end
    if params[:delete_price_category]
      menu.delete_price_category(params[:delete_price_category])
    end
    if params[:delete]
      menu.delete_dish(params[:delete])
    end
    if menu.save!
      redirect_to :controller => 'menus', :action => 'edit', :id => menu.slug
    else
      raise "Menu did not save"
    end
  end
    
end