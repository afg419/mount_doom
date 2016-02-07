require 'test_helper'

class CharacterShowPageRendersSkillsAndItemsTest < ActionDispatch::IntegrationTest
  test "character show page has all character information" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    item_skill_set = SkillSet.create(strength: 1,
                                    dexterity: 2,
                                 intelligence: 3,
                                       health: 4,
                                        money: 5,
                                        speed: 6)

    item1 = Item.create(name: "dagger", skill_set: item_skill_set)
    item2 = Item.create(name: "bowling ball", skill_set: item_skill_set)
    @character.items << [item1, item2]

    visit character_path(@character)

    within(".aggregate-stats") do
      assert page.has_content?("Strength: 12")
      assert page.has_content?("Dexterity: 14")
      assert page.has_content?("Intelligence: 16")
      assert page.has_content?("Speed: 22")

      assert page.has_content?("Bank: 20")
      assert page.has_content?("Health: 18")
      assert page.has_content?("Location: Bree")
    end

    within(".avatar-stats") do
      assert page.has_content?("Strength: 10")
      assert page.has_content?("Dexterity: 10")
      assert page.has_content?("Intelligence: 10")
      assert page.has_content?("Speed: 10")
    end

    within(".inventory") do
      assert page.has_content?("Dagger")
      assert page.has_content?("Bowling ball")
    end
  end

end
