class AddColumnSkillSetIdToItems < ActiveRecord::Migration
  def change
    add_reference :items, :skill_set, index: true, foreign_key: true
  end
end
