class Stop < ActiveRecord::Base
  has_many :line_stops
  has_many :subway_lines, :through => :line_stops
end
