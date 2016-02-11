require 'test_helper'

class HelpPageTest < ActionDispatch::IntegrationTest
  test "user in game can view help page" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns("true")

    visit journey_path(@location)

    within (".right") do
      click_on "Help"
    end
    
    assert_equal help_path, current_path
  end
end
