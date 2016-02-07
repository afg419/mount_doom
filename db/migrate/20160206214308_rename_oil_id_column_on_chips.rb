class RenameOilIdColumnOnChips < ActiveRecord::Migration
  def change
    rename_column :chips, :oil_id, :category_id
  end
end
