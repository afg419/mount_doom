require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  should belong_to :avatar
  should belong_to :user
  should belong_to :location
  should have_many :items

  test "can compute total skills from items and avatar" do
    char = create(:character)

    blacksmith = Category.create(name: "blacksmith")
    armory = Category.create(name: "armory")
    apothecary = Category.create(name: "apothecary")
    inn = Category.create(name: "inn")

    weapon_ss = SkillSet.create(strength: 1)
    armor_ss = SkillSet.create(speed: -1)
    apothecary_ss = SkillSet.create(health: 1)
    inn_ss = SkillSet.create(intelligence: 1)

    i1 = char.items.create(name: "sword1", category: blacksmith, skill_set: weapon_ss)
    i2 = char.items.create(name: "sword2", category: blacksmith, skill_set: weapon_ss )
    i3 = char.items.create(name: "armor1", category: armory, skill_set: armor_ss )
    i4 = char.items.create(name: "salve1", category: apothecary, skill_set: apothecary_ss )
    i5 = char.items.create(name: "salve2", category: apothecary, skill_set: apothecary_ss )
    i6 = char.items.create(name: "salve3", category: apothecary, skill_set: apothecary_ss )
    i7 = char.items.create(name: "food1", category: inn, skill_set: inn_ss )

    char.equip_weapon(i1)
    char.equip_armor(i3)
    current_skills = char.current_skills

    assert_equal 11, current_skills["strength"]
    assert_equal 10, current_skills["dexterity"]
    assert_equal 11, current_skills["intelligence"]
    assert_equal 13, current_skills["health"]
    assert_equal 10, current_skills["money"]
    assert_equal 9, current_skills["speed"]
  end
end
