class Menu < CouchRest::Model::Base
  use_database CouchServer.default_database
  property :name
  property :menu_sections
  property :site
  property :slug
  property :price_categories, :default => []
  property :menu_type
  property :dishes, :cast_as => [Dish]
  
  view_by :site
  view_by :name
  view_by :site_and_slug,  :map =>
  "function(doc) {
    if ((doc['couchrest-type'] == 'Menu') && (doc['slug'] != null)) {
      emit([doc['site'], doc['slug']], null);
    }
  }"
  
  set_callback :save, :before, :set_slug
  
  def set_slug
    slug = name.parameterize('_').to_s
    self['slug'] = slug
  end
  
  def to_param
    slug
  end
  
  def add_dish(options)
    new_id = Integer(dishes.size) + 1
    css_id = "#{slug}_dish_#{new_id}"
    default_params = {'css_id' => css_id}
    options.nil? ? params = default_params : params = default_params.merge(options)
    self.dishes << Dish.new(params)
    self.save!
  end
  
  def delete_dish(params)
    value = Integer(params.index("Delete"))
    self.dishes.delete_at(value)
    self.save
  end
  
  def add_price_category(cat)
    price_categories << cat
  end
  
  def delete_price_category(params)
    value = Integer(params.index("Delete"))
    price_categories.delete_at(value)    
  end
    
end