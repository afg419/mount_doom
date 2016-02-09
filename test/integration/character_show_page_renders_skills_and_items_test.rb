require 'test_helper'

class CharacterShowPageRendersSkillsAndItemsTest < ActionDispatch::IntegrationTest
  test "character show page has all character information" do
    create_start_of_game
    create_character_with_many_items(@character)
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    # item_skill_set = SkillSet.create(strength: 1,
    #                                 dexterity: 2,
    #                              intelligence: 3,
    #                                    health: 4,
    #                                     money: -3,
    #                                     speed: 6)
    #
    # item1 = Item.create(name: "dagger", skill_set: item_skill_set)
    # item2 = Item.create(name: "bowling ball", skill_set: item_skill_set)
    # @character.items << [item1, item2]

    @character.equip_weapon(@sword)
    @character.equip_armor(@armor)

    visit character_path(@character)

    within(".aggregate-stats") do
      assert page.has_content?("Strength: 11")
      assert page.has_content?("Dexterity: 10")
      assert page.has_content?("Intelligence: 11")
      assert page.has_content?("Speed: 9")

      assert page.has_content?("Money: $10")
      assert page.has_content?("Health: 13")
      assert page.has_content?("Location: Bree")
    end

    within(".avatar-stats") do
      assert page.has_content?("Strength: 10")
      assert page.has_content?("Dexterity: 10")
      assert page.has_content?("Intelligence: 10")
      assert page.has_content?("Speed: 10")
      assert page.has_content?("Health: 10")
      assert page.has_content?("Money: 10")
    end

    within(".inventory") do
      assert page.has_content?("Sword1")
      assert page.has_content?("Sword2")
      assert page.has_content?("Armor1")
      assert page.has_content?("Salve1")
      assert page.has_content?("Salve2")
      assert page.has_content?("Salve3")
      assert page.has_content?("Food1")
    end
  end

  test "character show page allows equipping" do

  end

end
