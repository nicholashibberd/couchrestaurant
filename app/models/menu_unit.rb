class MenuUnit < Unit
  property :name
  property :dishes, :cast_as => [Dish]
  
end