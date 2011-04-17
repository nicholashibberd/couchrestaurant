class MenusController < ApplicationController
  layout 'admin'

  def new
    @menu = Menu.new
  end
  
  def index
    @menu = @site.menus
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
    if menu.save!
      redirect_to admin_path
    else
      raise "Menu did not save"
    end
  end
end