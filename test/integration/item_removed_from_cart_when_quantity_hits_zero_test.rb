require "test_helper"

class ItemRemovedFromCartWhenQuantityHitsZeroTest < ActionDispatch::IntegrationTest
  # test "when quantity hits zero item is removed from cart" do
  #   create_shop
  #   visit items_path
  #
  #   within("#slotaitems") do
  #     click_button "Add to Cart"
  #   end
  #
  #   within("#dang-coconut") do
  #     click_button "Add to Cart"
  #   end
  #
  #   visit cart_items_path
  #
  #   within ('#slotaitems') do
  #     assert page.has_content?("Slotaitems")
  #     within ('.quantity') do
  #       assert page.has_content?("1")
  #     end
  #     click_button "remove"
  #   end
  #
  #   assert_equal cart_items_path, current_path
  #
  #   within (".items") do
  #     refute page.has_content?("Slotaitems")
  #   end
  #
  #   assert page.has_content?("Successfully removed Slotaitems from your cart.")
  #
  #   within (".cart_total") do
  #     assert page.has_content?("$17")
  #   end
  # end
end
