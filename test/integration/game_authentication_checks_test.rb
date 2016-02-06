require 'test_helper'

class GameAuthenticationChecksTest < ActionDispatch::IntegrationTest
  test "not logged in user can't access any game pages" do
    bree = Location.create(name: "Bree", slug: "bree")
    visit journey_path(bree)
    assert_equal login_path, current_path

    visit store_path("bree-armory")
    assert_equal login_path, current_path

    c = Character.create

    visit character_path(c)
    assert_equal login_path, current_path
  end

  test "user not logged in can't visit new character page" do
    visit new_character_path
    assert_equal login_path, current_path

    assert page.has_content?("Login")
  end

  test "user who is logged in cannot see game pages without being in game" do
    bree = Location.create(name: "Bree", slug: "bree")
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

    visit journey_path(bree)
    assert_equal user_path(user), current_path
  end

  test "logged in and in game can't access any non-game pages" do
    user = create_user
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    ApplicationController.any_instance.stubs(:in_game).returns("true")

    skills = SkillSet.create(intelligence: 4, dexterity: 3, strength: 3, health: 3, money: 100, speed: 2)
    avatar = Avatar.create(name: "Taylor", image_url:"jojoj", skill_set: skills)
    character = Character.create(avatar: avatar)

    ApplicationController.any_instance.stubs(:current_character).returns(character)

    visit root_path
    assert_equal character_path(character), current_path

    visit new_character_path
    assert_equal character_path(character), current_path

    visit about_path
    assert_equal character_path(character), current_path

    visit login_path
    assert_equal character_path(character), current_path

    visit new_user_path
    assert_equal character_path(character), current_path

    visit user_path(user)
    assert_equal character_path(character), current_path
  end
end
