class SubwayLine < ActiveRecord::Base
  has_many :ride_feedbacks
  has_many :passengers, :through => :ride_feedbacks
  has_many :line_stops
  has_many :stops, :through => :line_stops
end
