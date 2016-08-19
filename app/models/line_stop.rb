class LineStop < ActiveRecord::Base
  belongs_to :subway_line
  belongs_to :stop
end
