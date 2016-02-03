class CreateSkillSets < ActiveRecord::Migration
  def change
    create_table :skill_sets do |t|
      t.integer :strength
      t.integer :dexterity
      t.integer :intelligence
      t.integer :health

      t.timestamps null: false
    end
  end
end
