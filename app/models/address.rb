class Address < Hash
  include CouchRest::Model::CastedModel
  
  property :line_1
  property :line_2
  property :city
  property :county
  property :postcode
  property :country

  def to_s
    address_str = "#{line_1}"
    address_str << ",\n #{line_2}" if line_2
    address_str << "\n"
    address_str << "#{city}, " if city
    address_str << "#{county}" if county
    address_str << " #{postcode}" if postcode
    address_str << "\n#{country}" if country
    address_str
  end
end