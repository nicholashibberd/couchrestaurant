require 'couchrest_model'
class Sitting < Hash
  include CouchRest::Model::CastedModel

  property :name
  property :from, :default => 18.hours
  property :to, :default => 24.hours
  property :increment, :default => 30.minutes
  property :capacity
  
  def timeslots
    Array.new(1 + (Integer(to) - Integer(from))/Integer(increment)) do |i|
      (Time.now.midnight + (i*Integer(increment)) + Integer(from)).strftime("%H:%M")
    end
  end
  
  def from_timeslot
    (Time.now.midnight + Integer(from)).strftime("%H:%M")
  end

  def to_timeslot
    (Time.now.midnight + Integer(to)).strftime("%H:%M")
  end

  def slug
    name.parameterize('_')
  end
  
end