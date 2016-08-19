class RideFeedback < ActiveRecord::Base
  belongs_to :passenger
  belongs_to :subway_line

  # validates_presence_of :passenger_id, :train_id
  validates_length_of :content, minimum: 10, too_short: "Your feedback is too short. Please elaborate on your experience."
  
end
