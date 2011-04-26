class Message < CouchRest::Model::Base
  use_database CouchServer.default_database
  property :name, String
  property :details
  property :site
  property :phone  
  property :email  
end