class CreateShouts < ActiveRecord::Migration
  def change
    create_table :shouts do |t|
      t.integer :user_id
      t.text :body

      t.timestamps null: false
    end
  end
end
