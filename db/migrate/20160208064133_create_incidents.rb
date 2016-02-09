class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.references :skill_set, index: true, foreign_key: true
      t.references :character, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
