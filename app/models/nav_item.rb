require 'couchrest_model'
class NavItem < Hash
  include CouchRest::Model::CastedModel

  property :name
  property :slug
  property :children, :default => [], :cast_as => [NavItem]
  
  def parent_slug
    if self.casted_by.class == NavItem
      self.casted_by.slug
    else
      return nil
    end
  end
  
  def has_children?
    !self.children.empty?
  end
  
  def show_children(current_page)
    current_page == self.slug && self.has_children? || self.children_list.include?(current_page)
  end
  
  def children_list
    self.children.map(&:slug)
  end
  
  def selected?(current_page)
    current_page == self.slug ? 'selected' : nil
  end
      
end
