class Dish < Hash
  include CouchRest::Model::CastedModel
  attr_accessor :casted_by

  property :name
  property :description
  property :price_points, :cast_as => [PricePoint]
  property :css_id
  
  def add_price
    self.price_points << PricePoint.new
  end
  
  def delete_price(params)
    value = Integer(params.index("Delete"))
    self.price_points.delete_at(value)
  end  
  
  def price_display
    all_prices = []
    self.price_points.each {|p| all_prices << p.price}
    all_prices.join(" / ")
  end
  
  def menu
    self.casted_by
  end
  
  def find_price_by_price_category(cat)
    price_point = self.price_points.select {|p| p.description == cat}.first
    return price_point.price unless price_point.nil?
  end

end
