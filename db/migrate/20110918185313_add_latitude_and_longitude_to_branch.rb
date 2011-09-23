class AddLatitudeAndLongitudeToBranch < ActiveRecord::Migration
  def change
    add_column :branches, :latitude, :float
    add_column :branches, :longitude, :float
  end
end
