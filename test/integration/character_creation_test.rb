require 'test_helper'

class CharacterCreationTest < ActionDispatch::IntegrationTest
  test "logged in user can create a new character" do
    create_user
    login_user

    user = User.last

    assert_equal user_path(user), current_path

    click_on "Start New Game"
    find('#organizationSelect').find(:xpath, 'option[2]').select_option
    click_on "Begin Journey!"

    assert_equal
  end
end
