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
  
  OPENING_TIMES = ['11:00', '11:30', '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00', '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', '22:00', '22:30', '23:00', '23:30']
  
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

  def by_time(starttime)
    Reservation.by_site_and_time(:startkey => [domain, starttime], :endkey => [domain, starttime + 1.hour], :reduce => true)
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