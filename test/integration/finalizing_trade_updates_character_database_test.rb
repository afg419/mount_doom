require 'test_helper'

class FinalizingTradeUpdatesCharacterDatabaseTest < ActionDispatch::IntegrationTest
  test "" do
    create_start_of_game
    elvish_sword_skill_set = SkillSet.create()
    Item.create(name: "Elvish sword")
  end
end
