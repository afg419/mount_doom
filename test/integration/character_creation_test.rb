require 'test_helper'

class CharacterCreationTest < ActionDispatch::IntegrationTest
  test "logged in user can create a new character" do
    create_start_of_game

    visit user_path(@user)

    click_on "Start New Game"

    within(".profile-#{@character.avatar.id}") do
      click_on "Begin Journey!"
    end

    assert_equal journey_path(@location), current_path
  end
end
