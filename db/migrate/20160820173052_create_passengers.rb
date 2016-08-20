class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string :alias
      t.string :password_digest
      t.string :email
    end
  end
end
