class NavMenusController < ApplicationController
  layout 'admin'
  
  def new
    @nav_menu = NavMenu.new
  end
  
  def create
    nav_menu = NavMenu.new(params[:nav_menu])
    @site.nav_menus << nav_menu
    @site.save
    redirect_to admin_path
  end

  def update_nav_menu
    slug = params[:nav_menu][:slug]
    nav_menu = @site.find_nav_menu(slug)
    nav_menu_number = @site.nav_menus.index(nav_menu)
    @site.nav_menus[nav_menu_number] = params[:nav_menu]
    @site.save
    if params[:commit] == 'Add nav item'
      @site.nav_menus[nav_menu_number].add_nav_item
      @site.save
    end
    if params[:delete]
      @site.nav_menus[nav_menu_number].delete_nav_item(params[:delete])
      @site.save
    end
    if params[:add_submenu]
       @site.nav_menus[nav_menu_number].add_submenu(params[:add_submenu])
       @site.save
     end
    
    redirect_to :action => 'edit', :id => slug
  end
  
  def edit
    @pages = @site.pages
    @nav_menu = @site.find_nav_menu(params[:id])
  end
  
  
end