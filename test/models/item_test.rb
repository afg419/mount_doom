require "test_helper"

class ItemTest < ActiveSupport::TestCase
  should belong_to :itemable
  should belong_to :skill_set

  test "category and cat_attributes test" do
    blacksmith = Category.create(name: "blacksmith")
    armory = Category.create(name: "armory")
    weapon_ss = SkillSet.create(strength: 1)
    armor_ss = SkillSet.create(speed: -1)

    i1 = Item.create(name: "sword1", category: blacksmith, skill_set: weapon_ss)
    i2 = Item.create(name: "sword2", category: blacksmith, skill_set: weapon_ss )
    i3 = Item.create(name: "sword3", category: blacksmith, skill_set: weapon_ss )
    i4 = Item.create(name: "armor1", category: armory, skill_set: armor_ss )
    i5 = Item.create(name: "armor2", category: armory, skill_set: armor_ss )

    swords = Item.of_category("blacksmith").map(&:name)
    armors = Item.of_category("armory").map(&:name)

    assert_equal ["sword1", "sword2", "sword3"], swords
    assert_equal ["armor1", "armor2"], armors

    sword_attributes = Item.category_attributes("blacksmith")
    armor_attributes = Item.category_attributes("armory")

    assert_equal [{"strength" => 1}, {"strength" => 1}, {"strength" => 1}], sword_attributes
    assert_equal [{"speed" => -1}, {"speed" => -1}], armor_attributes
  end
end
