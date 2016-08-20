class CreateRideFeedbacks < ActiveRecord::Migration
  def change
    create_table :ride_feedbacks do |t|
      t.integer :passenger_id
      t.integer :subway_line_id
      t.integer :rating
      t.text :content
    end
  end
end
