require "test_helper"

class IndexViewTest < ActionDispatch::IntegrationTest
  test 'user does not see item description on index page' do
    create_shop
    visit items_path

    refute page.has_content?("Super yummy")
  end

end
