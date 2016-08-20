class SubwayLine < ActiveRecord::Base
  has_many :ride_feedbacks
  has_many :passengers, :through => :ride_feedbacks
end
