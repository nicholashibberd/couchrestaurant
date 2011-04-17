class Menu < CouchRest::Model::Base
  use_database CouchServer.default_database
  property :name
  property :menu_sections, :cast_as => [MenuSection], :default => [], :init_method => "new_instance"
  property :site
  property :slug
  
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
  
  def add_section(content_type, options)
    new_id = Integer(existing_sections(content_type)) + 1
    css_id = "#{slug}_#{content_type}_#{new_id}"
    default_params = {'content_type' => content_type, 'css_id' => css_id}
    options.nil? ? params = default_params : params = default_params.merge(options)
    self.menu_sections << MenuSection.new_instance(params)
    self.save!
  end
  
  def existing_sections(content_type)
    menu_sections.select {|section| section.has_value?(content_type) }.size
  end
  
  
  

end