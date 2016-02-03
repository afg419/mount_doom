require 'test_helper'

class GameNavbarTest < ActionDispatch::IntegrationTest
  test "user starts game and sees game nav" do
    create_user
    login_user

    skills = SkillSet.create(intelligence: 4, dexterity: 3, strength: 3, health: 3)
    avatar = Avatar.create(name: "Taylor", image_url:"jojoj", skill_set: skills)

    visit new_character_path

    within ".Taylor" do
      click_on "Begin Journey!"
    end

    assert_equal journey_path("bree"), current_path
  end
end
