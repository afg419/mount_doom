class AddLocationIdToCharacters < ActiveRecord::Migration
  def change
    add_reference :characters, :location, index: true, foreign_key: true
  end
end
