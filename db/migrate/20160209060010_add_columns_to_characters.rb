class AddColumnsToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :equipped_armor_id, :integer
    add_column :characters, :equipped_weapon_id, :integer
  end
end
