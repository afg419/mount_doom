class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.references :location, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
