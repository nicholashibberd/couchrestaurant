module DishesHelper
  def display_price_categories_for_dish(menu, price_point)
    if menu.menu_type == 'table'
      select_tag "dish[price_points][][description]", options_for_select(menu.price_categories, price_point.description)
    else
      text_field_tag "dish[price_points][][description]", price_point.description
    end
  end
end