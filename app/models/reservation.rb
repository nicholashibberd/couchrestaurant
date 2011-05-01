class Reservation < CouchRest::Model::Base
  use_database CouchServer.default_database
  property :name, String
  property :email, String
  property :phone, String
  property :date, :cast_as => Date
  property :time, :cast_as => DateTime
  property :date_of_booking, :cast_as => Date
  property :group_size, Integer
  property :site
  
  view_by :site
  view_by :time
  view_by :group_size
  view_by :name
  view_by :site_and_time,  
    :map => 
      "function(doc) {
          if ((doc['couchrest-type'] == 'Reservation') && (doc['time'] != null)) {
            emit([doc['site'], doc['time']], doc['group_size']);
          }
        }",
    :reduce => 
      "function(keys, values, reduce) {
        return sum(values)
      }"
      
  
end