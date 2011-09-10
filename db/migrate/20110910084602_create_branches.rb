class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.references :restaurant
      t.string :street_address
      t.string :city
      t.string :phone
      t.string :business_hours
      t.string :email

      t.timestamps
    end
    add_index :branches, :restaurant_id
  end
end
