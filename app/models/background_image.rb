require 'couchrest_model'
class BackgroundImage < Hash
  include CouchRest::Model::CastedModel
  property :filename
  property :slug
  property :site
end