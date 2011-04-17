class UnitsController < ApplicationController
  layout 'admin'
  def show
    @page = @site.find_page(params[:page_id])
    @unit = @page.units[1]
  end
  
  def new
    @page = @site.find_page(params[:page_id])
    if params[:content_type] == 'menu'
      @menu = MenuUnit.new
      3.times do 
        dish = Dish.new
        @menu.dishes << dish
      end
    end
  end
  
  def edit
    @page = @site.find_page(params[:page_id])
    unit_number = Integer(params[:id])
    @unit = @page.units[unit_number]
  end
  
  def update_unit
    page = @site.find_page(params[:page_id])
    unit_number = Integer(params[:id])
    page.units[unit_number] = params[:unit]
    page.save!
    
    if params[:commit] == 'Add dish'
      unit = page.units[unit_number]
      unit.add_dish
      page.save!
      redirect_to :controller => 'units', :action => 'edit', :page_id => page.slug, :id => unit_number
    elsif params[:delete]
      unit = page.units[unit_number]
      unit.delete_dish(params[:delete])
      page.save!
      redirect_to :controller => 'units', :action => 'edit', :page_id => page.slug, :id => unit_number
    else
      redirect_to :controller => 'pages', :action => 'edit', :id => page.slug
    end
  end
  
  def create_unit
    page = @site.find_page(params[:page_id])
    page.add_element(params['content_type'], params[:unit])
    redirect_to :controller => 'pages', :action => 'edit', :id => page.slug
  end
end