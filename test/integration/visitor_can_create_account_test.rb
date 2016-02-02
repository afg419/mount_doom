require "test_helper"

class VisitorCanCreateAccountTest < ActionDispatch::IntegrationTest

  test "visitor can create account" do

    visit "/"

    within (".right") do
      assert page.has_content?("Login")
    end

    click_link "Create Account"

    fill_in "Username", with: "John"
    fill_in "Password", with: "Password"

    click_button "Create Account"

    assert page.has_content? "Logged in as John"
    assert_equal user_path(User.last.id), current_path

    refute page.has_content?("Login")
    assert page.has_content?("Logout")
  end
end
