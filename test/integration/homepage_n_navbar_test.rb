require 'test_helper'

class HomepageNNavbarTest < ActionDispatch::IntegrationTest
  test "main navbar and login content conditionally renders" do
    create_user
    visit root_path

    assert page.has_content?("Create Account")
    assert page.has_content?("Login")
    assert page.has_content?("Mission")
    refute page.has_content?("Logout")
    refute page.has_content?("Dashboard")

    login_user
    visit root_path

    assert page.has_content?("Logout")
    assert page.has_content?("Dashboard")
    refute page.has_content?("Login")
    refute page.has_content?("Create Account")
  end
end
