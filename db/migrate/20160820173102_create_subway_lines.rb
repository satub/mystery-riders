class CreateSubwayLines < ActiveRecord::Migration
  def change
    create_table :subway_lines do |t|
      t.string :line
      t.string :logo
    end
  end
end
