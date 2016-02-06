class AddCategoryToChip < ActiveRecord::Migration
  def change
    add_reference :chips, :category, index: true, foreign_key: true
  end
end
