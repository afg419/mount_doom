require "test_helper"

class VisitorCanEditCartTest < ActionDispatch::IntegrationTest
  # test "visitor can remove an item from his or her cart" do
  #   category_1 = Category.create(name: "Lard")
  #   category_2 = Category.create(name: "Coconut Category")
  #
  #   Item.create(name: "Slotaitems", price: 20,
  #               description: "Super yummy", category_id: category_1.id)
  #   Item.create(name: "Trader Joe's BBQ", price: 15,
  #               description: "I'd trade slota for these!",
  #               category_id: category_2.id)
  #   Item.create(name: "Dang Coconut", price: 17,
  #               description: "Dang, these are good", category_id: category_2.id)
  #   Item.create(name: "Lard Yummies", price: 19,
  #               description: "Chock Full of Lard", category_id: category_1.id)
  #
  #   visit items_path
  #
  #   within("#slotaitems") do
  #     click_button "Add to Cart"
  #   end
  #
  #   visit cart_items_path
  #
  #   within('#slotaitems') do
  #     click_link "Remove"
  #   end
  #
  #   assert_equal cart_items_path, current_path
  #
  #   assert page.has_content?("Successfully removed Slotaitems from your cart.")
  #
  #   within(".items") do
  #     refute page.has_content?("Slotaitems")
  #   end
  #
  #   click_link "Slotaitems"
  #   assert_equal "/items/slotaitems", current_path
  # end
  #
  # test "user can adjust the quantity of an item in the cart" do
  #   category_1 = Category.create(name: "Lard")
  #   category_2 = Category.create(name: "Coconut Category")
  #
  #   Item.create(name: "Slotaitems", price: 20.50,
  #               description: "Super yummy", category_id: category_1.id)
  #   Item.create(name: "Trader Joe's BBQ", price: 15,
  #               description: "I'd trade slota for these!",
  #               category_id: category_2.id)
  #   Item.create(name: "Dang Coconut", price: 17,
  #               description: "Dang, these are good", category_id: category_2.id)
  #   Item.create(name: "Lard Yummies", price: 19,
  #               description: "Chock Full of Lard", category_id: category_1.id)
  #
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
  #     click_button "add"
  #   end
  #
  #   assert_equal cart_items_path, current_path
  #
  #   within ('#slotaitems') do
  #     within ('.quantity') do
  #       assert page.has_content?("2")
  #     end
  #     within ('.subtotal') do
  #       assert page.has_content?("41")
  #     end
  #   end
  #
  #   within (".cart_total") do
  #     assert page.has_content?("$58")
  #   end
  #
  #   within ('#slotaitems') do
  #     click_button "remove"
  #   end
  #
  #   assert_equal cart_items_path, current_path
  #
  #   within ('#slotaitems') do
  #     within ('.quantity') do
  #       assert page.has_content?("1")
  #     end
  #     within ('.subtotal') do
  #       assert page.has_content?("20")
  #     end
  #   end
  #
  #   within (".cart_total") do
  #     assert page.has_content?("$37")
  #   end
  # end
end
