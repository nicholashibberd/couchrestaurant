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
  property :nav_menus, :cast_as => [NavMenu], :default => []
  property :capacity, Integer
  property :sittings, :cast_as => [Sitting], :default => []
  
  view_by :domain
  view_by :name
  
  TIMESLOTS = [["11:00", 39600],["11:30", 41400],["12:00", 43200],["12:30", 45000],["13:00", 46800],["13:30", 48600],["14:00", 50400],["14:30", 52200],["15:00", 54000],["15:30", 55800],["16:00", 57600],["16:30", 59400],["17:00", 61200],["17:30", 63000],["18:00", 64800],["18:30", 66600],["19:00", 68400],["19:30", 70200],["20:00", 72000],["20:30", 73800],["21:00", 75600],["21:30", 77400],["22:00", 79200],["22:30", 81000],["23:00", 82800],["23:30", 84600],["00:00", 86400]]
  INCREMENTS = [["15 minutes", 900], ["30 minutes", 1800], ["45 minutes", 2700], ["1 hour", 3600]]
  
  def menus
    Menu.by_site(:key => domain)
  end

  def pages
    Page.by_site_domain(:key => domain)
  end
  
  def top_level_pages
    pages.select {|page| !page.has_parent?}
  end
  
  def find_page(parent, slug)
    Page.by_site_domain_parent_and_slug(:key => [domain, parent, slug]).first
  end
  
  def find_menu(slug)
    Menu.by_site_and_slug(:key => [domain, slug]).first
  end
  
  def find_sitting(name)
    sittings.select {|sitting| sitting.slug == name}.first
  end

  def find_nav_menu(name)
    nav_menus.select {|nav_menu| nav_menu.slug == name}.first
  end
  
  def by_time(starttime)
    Reservation.by_site_and_time(:startkey => [domain, starttime], :endkey => [domain, starttime + 1.hour], :reduce => true)
  end

  def all_bookings_by_time(date, time)
    datetime_string = date.to_s + " " + time.to_s
    datetime = DateTime.parse(datetime_string)
    Reservation.by_site_and_time(:startkey => [domain, datetime], :endkey => [domain, datetime + 1.hour])
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

  def number_of_bookings(date, time)
    datetime_string = date.to_s + " " + time.to_s
    datetime = DateTime.parse(datetime_string)
    availability_hash = by_time(datetime)["rows"]
    if availability_hash.empty?
      0
    else
      Integer(by_time(datetime)["rows"].first["value"])
    end
  end
  
  def timeslot_available?(date, time)
    current_bookings = number_of_bookings(date, time)
    if capacity - current_bookings > 1
      true
    else
      false
    end
  end
  
  def available_spaces(date, time)
    capacity - number_of_bookings(date, time)
  end
  
    
end