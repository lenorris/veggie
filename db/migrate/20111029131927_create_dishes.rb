class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :description
      t.string :notice
      t.decimal :price
      t.references :user
      t.references :restaurant

      t.timestamps
    end
    add_index :dishes, :user_id
    add_index :dishes, :restaurant_id
  end
end
