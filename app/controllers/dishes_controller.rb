class DishesController < ApplicationController
  layout 'admin'
  
  def new
    @menu = @site.find_menu(params[:menu_id])
    @dish = Dish.new
  end
  
  
  def edit
    menu = @site.find_menu(params[:menu_id])
    unit_number = Integer(params[:id])
    @dish = menu.dishes[unit_number]

  end
  
  def update_dish
    menu = @site.find_menu(params[:menu_id])
    dish_number = Integer(params[:id])
    menu.dishes[dish_number] = params[:dish]
    menu.save!
    if params[:commit] == 'Add price'
      dish = menu.dishes[dish_number]
      dish.add_price
      menu.save!
      redirect_to :controller => 'dishes', :action => 'edit', :menu_id => menu.slug, :id => dish_number
    elsif params[:delete]
      dish = menu.dishes[dish_number]
      dish.delete_price(params[:delete])
      menu.save!
      redirect_to :controller => 'dishes', :action => 'edit', :menu_id => menu.slug, :id => dish_number
    else
      redirect_to :controller => 'menus', :action => 'edit', :id => menu.slug
    end
    
  end
  
  def create_dish
    menu = @site.find_menu(params[:menu_id])
    menu.add_dish(params[:dish])
    if params[:commit] == 'Add price'
      dish_number = menu.dishes - 1 #should this be menu.dishes.size?
      dish = menu.dishes.last
      dish.add_price
      menu.save!
      redirect_to :controller => 'dishes', :action => 'edit', :menu_id => menu.slug, :id => dish_number
    else
      redirect_to :controller => 'menus', :action => 'edit', :id => menu.slug 
    end
  end
end