class MenuUnit < Unit
  include CouchRest::Model::CastedModel
  attr_accessor :casted_by
  property :menu_slug
  
  def menu
    Menu.by_site_and_slug(:key => [site, menu_slug]).first
  end
  
  def site
    self.casted_by.site
  end
  
end