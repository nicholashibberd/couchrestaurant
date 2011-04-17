require 'couchrest_model'
class MenuSection < Hash
  include CouchRest::Model::CastedModel
  attr_accessor :casted_by

  property :content_type
  property :css_id
  property :section_id
  
  def self.new_instance(params)
    case params['content_type']
    when 'dish'
      Dish.new(params)
    when 'textbox'
      TextBoxUnit.new(params)
    else
      MenuSection.new(params)
    end
  end
  
  def set_css_id
    menu = casted_by
    new_id = Integer(menu.existing_units(content_type)) + 1
    "#{content_type}_#{new_id}"
  end
  
  
end
