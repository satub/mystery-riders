class AddSubwayLinesData < ActiveRecord::Migration
  def change
    subway_lines = ["1", "2", "3", "4", "5", "6",
      "7", "A", "B", "C", "D", "E", "F",
      "G", "J", "L", "M", "N", "R", "S", "Q", "Z"]
    subway_lines.each do |line|
      SubwayLine.create(:line => line)
    end
  end
end
