require "test_helper"

class UserCanLoginTest < ActionDispatch::IntegrationTest
  test "user can login" do
    user = User.create(username: "Aaron-da-boss", password: "Unicorn")

    visit "/"

    within (".right") do
      assert page.has_content?("Login")
    end

    within(".right") do
      click_link "Login"
    end

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password

    click_button "Login"

    assert page.has_content? "Logged in as Aaron-da-boss"
    assert_equal user_path(User.last.id), current_path

    refute page.has_content?("Login")
    assert page.has_content?("Logout")

    within(".right") do
      click_link "Logout"
    end

    assert_equal root_path, current_path
    refute page.has_content?("Logout")
    assert page.has_content?("Login")
  end

  test 'assert_user_cannot_login_with_incorrect_information' do
    User.create(username: "Shannon", password: "Password")

    visit "/"
    within(".right") do
      click_link "Login"
    end

    fill_in "Username", with: "Mermaid"
    fill_in "Password", with: "Password"

    assert_equal "/login" , current_path
    click_button "Login"
    assert page.has_content?("Invalid Login.")
  end

  test 'user can sign up from login page' do
    visit login_path

    assert page.has_content?("Sign up!")

    click_link "Sign up!"

    assert_equal new_user_path, current_path
  end
end
