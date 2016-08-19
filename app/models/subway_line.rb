class SubwayLine < ActiveRecord::Base
  has_many :ride_feedbacks
  has_many :passengers, :through => :ride_feedbacks
  has_one :route
  has_many :route_stops, :through => :routes
  has_many :stops, :through => :route_stops
end
