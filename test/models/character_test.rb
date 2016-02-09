require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  should belong_to :avatar
  should belong_to :user
  should belong_to :location
  should have_many :items

  test "can compute total skills from items and avatar" do
    create_character_with_many_items

    @character.equip_weapon(@sword)
    @character.equip_armor(@armor)
    current_skills = @character.current_skills

    assert_equal 11, current_skills["strength"]
    assert_equal 10, current_skills["dexterity"]
    assert_equal 11, current_skills["intelligence"]
    assert_equal 13, current_skills["health"]
    assert_equal 10, current_skills["money"]
    assert_equal 9, current_skills["speed"]
  end

  test "can compute total skills without equipped items" do
    create_character_with_many_items

    @character.equip_weapon(@sword)
    current_skills = @character.current_skills

    assert_equal 11, current_skills["strength"]
    assert_equal 10, current_skills["dexterity"]
    assert_equal 11, current_skills["intelligence"]
    assert_equal 13, current_skills["health"]
    assert_equal 10, current_skills["money"]
    assert_equal 10, current_skills["speed"]
  end
end
