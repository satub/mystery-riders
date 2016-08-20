class AddLogoFileToSubwayLines < ActiveRecord::Migration
  def change
    add_column :subway_lines, :filename, :string
  end
end
