class AddCategoryToIncidents < ActiveRecord::Migration
  def change
    add_reference :incidents, :category, index: true, foreign_key: true
  end
end
