class RenameCategoryIdColumnOnChips < ActiveRecord::Migration
  def change
    rename_column :chips, :category_id, :category_id
  end
end
