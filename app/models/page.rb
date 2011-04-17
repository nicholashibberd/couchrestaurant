class Page < CouchRest::Model::Base
  use_database CouchServer.default_database
  property :name, String
  property :slug, String
  property :page_type
  property :units, :cast_as => [Unit], :default => [], :init_method => "new_instance"
  property :site
  property :background_images, :cast_as => [BackgroundImage], :default => []
  
  view_by :slug
  view_by :site_id
  view_by :site
  view_by :name
  
  view_by :site_and_slug,  :map => 
  "function(doc) {
    if ((doc['couchrest-type'] == 'Page') && (doc['slug'] != null)) {
      emit([doc['site'], doc['slug']], null);
    }
  }"
  
  def to_param
    slug
  end
    
  def menus
    Menu.by_page_id(:key => id)
  end
    
  def add_element(content_type, options)
    new_id = Integer(existing_units(content_type)) + 1
    css_id = "#{slug}_#{content_type}_#{new_id}"
    default_params = {'content_type' => content_type, 'css_id' => css_id}
    options.nil? ? params = default_params : params = default_params.merge(options)
    self.units << Unit.new_instance(params)
    self.save!
  end

  def add_dish(params)
    key = params.index("Add dish")
    array = self.units.select {|unit| unit.has_value?(key) }
    menu = array[0]
    menu.add_dish
  end
  
  def add_background_image(params)
    self.background_images << BackgroundImage.new(params)
    self.save
  end
  
  def delete_element(params)
    value = Integer(params.index("Delete"))
    unit = self.units[value]
    if unit['content_type'] == 'image'
      unit.delete_file
    end
    self.units.delete_at(value)
    self.save
  end
  
  def update_elements(content_units)
    self.units.clear
    content_units.each do |unit|
      new_unit = Unit.new_instance(unit)
      self.units << new_unit
    end
    self.save
  end
  
  def existing_units(content_type)
    units.select {|unit| unit.has_value?(content_type) }.size
  end
    
end