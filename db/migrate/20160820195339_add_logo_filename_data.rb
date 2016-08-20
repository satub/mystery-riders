class AddLogoFilenameData < ActiveRecord::Migration
  def change
    path = "public/images/lines"
    svg_files = Dir.glob("#{path}/*.svg")
    filenames = svg_files.collect {|file| file.split("/").last} #chop off the path from the filename
      # linenumber = filenames.collect do |name|
      #   name.match(/-(\w)(?=\.svg)/).captures[0]  #get line number
      # end
    filenames.each do |filename|
      sl = SubwayLine.find_by(:line => filename.match(/-(\w)(?=\.svg)/).captures[0])
      sl.update(:filename => filename)
    end

  end
end
