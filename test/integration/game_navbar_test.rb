require 'test_helper'

class GameNavbarTest < ActionDispatch::IntegrationTest
  test "user starts game and sees game nav" do
    create_start_of_game

    visit new_character_path

    within ".Legolas" do
      click_on "Begin Journey!"
    end

    assert_equal journey_path(@location), current_path
    assert page.has_content?("Help")
    refute page.has_content?("Logout")
    refute page.has_content?("Login")
  end

  test "user can see their character's name and money in navbar" do
    create_start_of_game

    visit new_character_path

    within ".Legolas" do
      click_on "Begin Journey!"
    end

    assert page.has_content?("Legolas")
    assert page.has_content?("$6")
  end

  test "navbar updates location to that of character" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns("true")

    location1 = Location.create(name: "Bree", slug: "bree")
    location2 = Location.create(name: "Rivendell", slug: "rivendell")

    visit journey_path(location1)
    assert page.has_content?("Bree")

    visit journey_path(location2)
    assert page.has_content?("Rivendell")
  end
end
