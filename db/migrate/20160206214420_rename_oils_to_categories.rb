class RenameCategorysToCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :slug, :string
    rename_table :categories, :categories
  end
end
