class RenameOilsToCategories < ActiveRecord::Migration
  def change
    remove_column :oils, :slug, :string
    rename_table :oils, :categories
  end
end
