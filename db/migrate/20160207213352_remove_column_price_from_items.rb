class RemoveColumnPriceFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :price, :integer
  end
end
