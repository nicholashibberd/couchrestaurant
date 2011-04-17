class Dish < MenuSection

  property :name
  property :description
  property :price_points, :cast_as => [PricePoint]
end
