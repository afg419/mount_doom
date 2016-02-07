require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  should belong_to :avatar
  should belong_to :user
  should belong_to :location
  should have_many :items

  test "can compute total skills from items and avatar" do
    char = create(:character)
    avatar_skill_set = char.avatar.skill_set

    item_skill_set = SkillSet.create(strength: 1,
                                    dexterity: 2,
                                 intelligence: 3,
                                       health: 4,
                                        money: 5,
                                        speed: 6)

    item1 = Item.create(name: "dagger", skill_set: item_skill_set)
    item2 = Item.create(name: "bowling ball", skill_set: item_skill_set)
    char.items << [item1, item2]

    current_skills = char.current_skills
    assert_equal 12, current_skills["strength"]
    assert_equal 14, current_skills["dexterity"]
    assert_equal 16, current_skills["intelligence"]
    assert_equal 18, current_skills["health"]
    assert_equal 20, current_skills["money"]
    assert_equal 22, current_skills["speed"]
  end
end
