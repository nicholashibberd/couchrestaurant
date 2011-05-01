require 'couchrest_model'
class NavMenu < Hash
  include CouchRest::Model::CastedModel

  property :name
  property :nav_items, :cast_as => [NavItem], :default => []
  
  def slug
    name.parameterize('_')
  end
  
  def add_nav_item    
    nav_items << NavItem.new
  end
  
  def add_submenu(params)
    value = params.index("Add submenu")
    nav_item = nav_items[Integer(value)]
    nav_item.children << NavItem.new
  end
  
  def delete_nav_item(params)
    value = params.index("Delete")
    nav_items.delete_at(Integer(value))
  end
  

end