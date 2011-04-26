module MenusHelper
  
  def menu_table(menu)
    concat tag("table", {:class => "generic-table"}, true)
    concat content_tag(:th)
    menu.price_categories.each do |cat|
      concat content_tag(:th, cat)
    end
    menu.dishes.each do |dish|
      concat tag("tr", nil, true)
        concat content_tag(:td, dish.name)
          menu.price_categories.each do |cat|
            concat content_tag(:td, dish.find_price_by_price_category(cat))
          end
      concat tag("/tr", nil, true)
    end
    concat tag("/table", nil, true)
  end 
  
  def display_menu(menu)
    menu_type = menu['menu_type']
    render :partial => "menus/#{menu_type}/template1", :locals => {:menu => menu}
    
  end 
  
  def display_price_categories(menu, &block)  
    content_tag(:div, nil, &block) if menu.menu_type == 'table'
  end
end