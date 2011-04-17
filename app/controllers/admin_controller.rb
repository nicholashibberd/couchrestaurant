class AdminController < ApplicationController
 layout "admin"
 
 def edit_nav_items
   @nav_items = @site.nav_items
   @pages = @site.pages

   if request.post?
     if params[:commit] == 'Add menu item'
       @site.add_nav_item
     end
     if params[:delete]
       @site.delete_nav_item(params[:delete])
     end
     if params[:add_submenu]
        @site.add_submenu(params[:add_submenu])
      end
     if params[:commit] == 'Save'
       @site.update_nav_items(params[:site][:nav_items])
       @site.save
     end
   end
 end

 def index
  @pages = @site.pages
  @menus = @site.menus
 end
     
end
