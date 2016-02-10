require "test_helper"

class AdminLoginTest < ActionDispatch::IntegrationTest
  test "admin can view their dashboard" do
    create_admin

    visit admin_dashboard_index_path

    assert page.has_content?("Admin Dashboard")
  end

  test "a registered user can not see the dashboard" do
    user = create(:user)

    visit admin_dashboard_index_path

    refute page.has_content?("Admin Dashboard")
    assert page.has_content?("Login")
  end

  test "a guest can not see the dashboard" do
    visit admin_dashboard_index_path

    refute page.has_content?("Admin Dashboard")
    assert page.has_content?("Login")
  end

end
