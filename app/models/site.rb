require 'couchrest_model'

class Site < CouchRest::Model::Base
  use_database CouchServer.default_database
  property :name
  property :domain
  property :address, :cast_as => Address
  property :phone
  property :latlong
  property :directions
  property :opening_times
  property :_id
  property :theme
  property :nav_items, :cast_as => [NavItem], :default => []
  
  view_by :domain
  view_by :name
  
  def menus
    Menu.by_site(:key => domain)
  end

  def pages
    Page.by_site(:key => domain)
  end
  
  def find_page(slug)
    Page.by_site_and_slug(:key => [domain, slug]).first
  end
  
  def find_menu(slug)
    Menu.by_site_and_slug(:key => [domain, slug]).first
  end

  def update_nav_items(nav_items)
      self.nav_items.clear
      nav_items.each do |nav_item|
        new_nav_item = NavItem.new(nav_item)
        self.nav_items << new_nav_item
      end  
  end  
  
  def add_nav_item
    self.nav_items << NavItem.new
  end
  
  def add_submenu(params)
    value = params.index("Add submenu")
    nav_item = self.nav_items[Integer(value)]
    nav_item.children << NavItem.new
  end
  
  def delete_nav_item(params)
    value = params.index("Delete")
    self.nav_items.delete_at(Integer(value))
  end
  
end