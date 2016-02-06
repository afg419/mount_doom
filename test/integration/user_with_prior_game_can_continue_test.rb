require 'test_helper'

class UserWithPriorGameCanContinueTest < ActionDispatch::IntegrationTest
  test "user can continue prior game" do
    legolas = create(:character)
    bree = legolas.location
    user = legolas.user
    ApplicationController.any_instance.stubs(:current_user).returns(user)
  
    visit user_path(user)

    click_on "Continue"

    assert_equal journey_path(bree), current_path
  end
end
