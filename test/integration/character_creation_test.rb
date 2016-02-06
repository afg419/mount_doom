require 'test_helper'

class CharacterCreationTest < ActionDispatch::IntegrationTest
  test "logged in user can create a new character" do
    create_user
    login_user

    skills = SkillSet.create(intelligence: 4, dexterity: 3, strength: 3, health: 3)
    avatar = Avatar.create(name: "Taylor", image_url:"jojoj", skill_set: skills)
    location = Location.create(name: "Bree", slug: "bree")

    user = User.last

    assert_equal user_path(user), current_path

    click_on "Start New Game"

    within(".profile-#{avatar.id}") do
      click_on "Begin Journey!"
    end

    assert_equal journey_path(location), current_path
  end
end
