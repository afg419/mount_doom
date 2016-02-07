class RemoveColumnFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :description, :string
    remove_column :items, :slug, :string
    remove_column :items, :status, :string
  end
end
