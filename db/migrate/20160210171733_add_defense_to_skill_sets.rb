class AddDefenseToSkillSets < ActiveRecord::Migration
  def change
    add_column :skill_sets, :defense, :integer
  end
end
