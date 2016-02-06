require 'test_helper'

class GameNavbarTest < ActionDispatch::IntegrationTest
  test "user starts game and sees game nav" do
    bree = Location.create(name: "Bree", slug: "bree")
    create_user
    login_user

    skills = SkillSet.create(intelligence: 4, dexterity: 3, strength: 3, health: 3)
    avatar = Avatar.create(name: "Taylor", image_url:"jojoj", skill_set: skills)

    visit new_character_path

    within ".Taylor" do
      click_on "Begin Journey!"
    end

    assert_equal journey_path(bree), current_path
    assert page.has_content?("Help")
    refute page.has_content?("Logout")
    refute page.has_content?("Login")
  end

  test "user can see their character's name and money in navbar" do
    bree = Location.create(name: "Bree", slug: "bree")
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
end
