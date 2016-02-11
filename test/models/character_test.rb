require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  should belong_to :avatar
  should belong_to :user
  should belong_to :location
  should have_many :items

  test "can compute total skills from items and avatar" do
    character = create(:character)
    create_character_with_many_items(character)

    character.equip_weapon(@sword)
    character.equip_armor(@armor)
    current_skills = character.current_skills

    assert_equal 11, current_skills["strength"]
    assert_equal 10, current_skills["dexterity"]
    assert_equal 11, current_skills["intelligence"]
    assert_equal 13, character.hp
    assert_equal 10, character.money
    assert_equal 9, current_skills["speed"]
  end

  test "can compute total skills without equipped items" do
    character = create(:character)
    create_character_with_many_items(character)

    character.equip_weapon(@sword)
    current_skills = character.current_skills

    assert_equal 11, current_skills["strength"]
    assert_equal 10, current_skills["dexterity"]
    assert_equal 11, current_skills["intelligence"]
    assert_equal 13, character.hp
    assert_equal 10, character.money
    assert_equal 10, current_skills["speed"]
  end

  test "injuries effect current attributes" do
    character = create(:character)
    create_character_with_many_items(character)

    injury_ss = create(:skill_set, health: -10, dexterity: -2,
                                              strength: 0,
                                                intelligence: 0,
                                                speed: 0,
                                                money: 10)
    character.incidents.create(name: "Hurts so good", skill_set: injury_ss)
    current_skills = character.current_skills

    assert_equal 10, current_skills["strength"]
    assert_equal 8, current_skills["dexterity"]
    assert_equal 11, current_skills["intelligence"]
    assert_equal 3, character.hp
    assert_equal 10, current_skills["speed"]
  end

  test "heal wounds does its work" do
    character = create(:character)

    5.times do |i|
      character.items.create(name: "item#{i}", label: "label#{i}")
    end

    5.times do |i|
      character.incidents.create(name: "incident#{i}", label: "label#{i+1}")
    end

    expected = [["item1", "incident0"],
              ["item2", "incident1"],
              ["item3", "incident2"],
              ["item4", "incident3"]]
    assert_equal expected, character.heal_wounds
    assert_equal 1, character.items.count
    assert_equal 1, character.incidents.count
  end
end
