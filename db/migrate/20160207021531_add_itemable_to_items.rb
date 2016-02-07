class AddItemableToItems < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.references :itemable, :polymorphic => true
    end
  end
end
