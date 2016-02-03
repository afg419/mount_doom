class AddMoneyAndSpeedToSkillSet < ActiveRecord::Migration
  def change
    add_column :skill_sets, :money, :integer
    add_column :skill_sets, :speed, :integer
  end
end
