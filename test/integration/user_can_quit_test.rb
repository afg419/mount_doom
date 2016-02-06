require 'test_helper'

class UserCanQuitTest < ActionDispatch::IntegrationTest
  test "user can save and quit game" do
    bree = Location.create(name: "Bree", slug: "bree")
    user = create_user
    login_user

    skills = SkillSet.create(intelligence: 4, dexterity: 3, strength: 3, health: 3, money: 100, speed: 2)
    avatar = Avatar.create(name: "Taylor", image_url:"jojoj", skill_set: skills)

    visit new_character_path

    within ".Taylor" do
      click_on "Begin Journey!"
    end

    assert page.has_content?("Help")

    click_on "Save and Quit"

    assert_equal user_path(user), current_path

    assert page.has_content?("Logout")
    refute page.has_content?("Help")
  end
end
