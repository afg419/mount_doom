class RemoveChipOrdersTable < ActiveRecord::Migration
  def change
    drop_table :chip_orders 
  end
end
