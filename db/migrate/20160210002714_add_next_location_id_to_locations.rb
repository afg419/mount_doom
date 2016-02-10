class AddNextLocationIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :next_location_id, :integer
  end
end
