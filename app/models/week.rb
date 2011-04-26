class Week < Hash
  include CouchRest::Model::CastedModel
  property :Monday
  property :Tuesday
  property :Wednesday
  property :Thursday
  property :Friday
  property :Saturday
  property :Sunday
end