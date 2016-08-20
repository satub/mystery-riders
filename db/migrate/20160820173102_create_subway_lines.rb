class CreateSubwayLines < ActiveRecord::Migration
  def change
    create_table :subway_lines do |t|
      t.string :line
    end
  end
end
