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
    assert page.has_content?("Help")
    refute page.has_content?("Logout")
    refute page.has_content?("Login")
  end

  test "user can see their character's name and money in navbar" do
    create_user
    login_user

    skills = SkillSet.create(intelligence: 4, dexterity: 3, strength: 3, health: 3, money: 100, speed: 2)
    avatar = Avatar.create(name: "Taylor", image_url:"jojoj", skill_set: skills)

    visit new_character_path

    within ".Taylor" do
      click_on "Begin Journey!"
    end

    assert page.has_content?("Taylor")
    assert page.has_content?("$100")
  end

  test "user who is logged in cannot see game pages without being in game" do
    user = create_user
    login_user

    skills = SkillSet.create(intelligence: 4, dexterity: 3, strength: 3, health: 3, money: 100, speed: 2)
    avatar = Avatar.create(name: "Taylor", image_url:"jojoj", skill_set: skills)

    visit new_character_path

    within ".Taylor" do
      click_on "Begin Journey!"
    end

    click_on "Save and Quit"

    character = Character.last

    visit character_path(character)
    assert_equal user_path(user), current_path

    visit journey_path("bree")
    assert_equal user_path(user), current_path
  end
end
