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
  
  def main_nav_item?
    self.casted_by.class == NavItem
  end
  
  def show_children(path)
    path.gsub!("/pages/", "")
    path == self.slug && self.has_children? || self.children_list.include?(path)
  end
  
  def children_list
    self.children.map(&:slug)
  end
  
  def selected?(path)
    path.gsub!("/pages/", "")
    if main_nav_item?
      path == self.slug ? 'child_selected' : nil      
    else
      path == self.slug || self.children_list.include?(path) ? 'selected' : nil
    end
  end
      
end
