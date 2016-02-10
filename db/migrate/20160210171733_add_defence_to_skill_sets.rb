class AddDefenceToSkillSets < ActiveRecord::Migration
  def change
    add_column :skill_sets, :defence, :integer
  end
end
