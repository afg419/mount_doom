require 'test_helper'

class UserWithPriorGameCanContinueTest < ActionDispatch::IntegrationTest
  test "user can continue prior game" do
    create_start_of_game

    visit user_path(@user)

    click_on "Continue"

    assert_equal journey_path(@location), current_path
  end
end
