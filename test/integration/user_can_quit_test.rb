require 'test_helper'

class UserCanQuitTest < ActionDispatch::IntegrationTest
  test "user can save and quit game" do
    create_start_of_game

    visit new_character_path

    within ".Legolas" do
      click_on "Begin Journey!"
    end

    assert page.has_content?("Help")

    click_on "Save and Quit"

    assert_equal user_path(@user), current_path

    assert page.has_content?("Logout")
    refute page.has_content?("Help")
  end
end
