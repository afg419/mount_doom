require 'test_helper'

class EndOfGameTest < ActionDispatch::IntegrationTest
  test "user wins and can restart game" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:status).returns("true")

    visit restart_game_path

    assert page.has_content?("You Won")

    click_button "Play Again"

    assert dashboard_path, current_path
  end

  test "user looses and can restart game" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:status).returns("false")

    visit restart_game_path

    assert page.has_content?("You Died")

    click_button "Play Again"

    assert dashboard_path, current_path
  end
end
