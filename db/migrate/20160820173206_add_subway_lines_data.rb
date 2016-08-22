class AddSubwayLinesData < ActiveRecord::Migration
  def change
    numbers = ["1", "2", "3", "4", "5", "6",
      "7", "A", "B", "C", "D", "E", "F",
      "G", "J", "L", "M", "N", "R", "S", "Q", "Z"]

    path = "public/images/lines"
    svg_files = Dir.glob("#{path}/*.svg")
    logos = svg_files.collect {|file| file.split("/").last} #chop off the path from the filename

    numbers.each_with_object(Hash.new) do |number, subway_lines|
      subway_lines[number] = logos.detect{|logo| logo.match(/-(\w)(?=\.svg)/).captures[0] == number}
    end.each {|number, logo| SubwayLine.create(:line => number, :logo => logo) }
  end
end
