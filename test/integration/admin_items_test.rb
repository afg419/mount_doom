require "test_helper"

class AdminItemsTest < ActionDispatch::IntegrationTest

  # def create_admin
  #   @admin = User.create(username: "admin",
  #                       password: "password",
  #                       role: 1)
  # end
  #
  # test "logged in admin sees items index" do
  #   create_admin
  #   category_1 = Category.create(name: "Lard")
  #   Item.create(name: "Slotaitems", price: 20,
  #               description: "Super yummy", category_id: category_1.id)
  #
  #   ApplicationController.any_instance.stubs(:current_user).returns(@admin)
  #   visit admin_items_path
  #   assert page.has_content?("All Items")
  #   assert page.has_content?("Slotaitems")
  # end
  #
  # test "default user does not see admin categories index" do
  #   user = User.create(username: "default_user",
  #                       password: "password",
  #                       role: 0)
  #
  #   ApplicationController.any_instance.stubs(:current_user).returns(user)
  #   visit admin_items_path
  #   refute page.has_content?("All Items")
  #   assert page.has_content?("The page you were looking for doesn't exist.")
  # end
  #
  # test "admin can edit item" do
  #   create_admin
  #   category_1 = Category.create(name: "Lard")
  #   Item.create(name: "Slotaitems", price: 20,
  #               description: "Super yummy", category_id: category_1.id)
  #   ApplicationController.any_instance.stubs(:current_user).returns(@admin)
  #
  #   visit admin_items_path
  #   within "#slotaitems" do
  #     click_link "Edit"
  #   end
  #
  #   fill_in "Name", with: "EditedName"
  #   click_button "Update Item"
  #
  #   assert_equal admin_items_path, current_path
  #   assert page.has_content? "EditedName"
  # end
  #
  # test "admin cannot remove name from item" do
  #   create_admin
  #   category_1 = Category.create(name: "Lard")
  #   Item.create(name: "Slotaitems", price: 20,
  #               description: "Super yummy", category_id: category_1.id)
  #   ApplicationController.any_instance.stubs(:current_user).returns(@admin)
  #
  #   visit admin_items_path
  #   within "#slotaitems" do
  #     click_link "Edit"
  #   end
  #
  #   fill_in "Name", with: ""
  #   click_button "Update Item"
  #
  #   assert page.has_content?("A item must have a name")
  # end
  #
  # test "admin can add item" do
  #   create_admin
  #   category_1 = Category.create(name: "Lard")
  #   ApplicationController.any_instance.stubs(:current_user).returns(@admin)
  #
  #   visit admin_items_path
  #   click_link "Add New Item"
  #   fill_in "Name", with: "NewItem"
  #   fill_in "Price", with: 1.99
  #   fill_in "Description", with: "Coolest of the items"
  #   click_button "Create Item"
  #
  #   assert admin_items_path, current_path
  #
  #   within(".items") do
  #     assert page.has_content?("NewItem")
  #   end
  # end
  #
  # test "admin cannot add item without a name" do
  #   create_admin
  #   category_1 = Category.create(name: "Lard")
  #   ApplicationController.any_instance.stubs(:current_user).returns(@admin)
  #
  #   visit admin_items_path
  #   click_link "Add New Item"
  #   fill_in "Price", with: 1.99
  #   fill_in "Description", with: "Coolest of the items"
  #   click_button "Create Item"
  #
  #   assert page.has_content?("A item must have a name")
  # end
  #
  # test "admin can delete item" do
  #   create_admin
  #   create_shop
  #   ApplicationController.any_instance.stubs(:current_user).returns(@admin)
  #
  #   visit admin_items_path
  #
  #   within("#slotaitems") do
  #     click_link "Delete"
  #   end
  #
  #   assert admin_items_path, current_path
  #
  #   within(".items") do
  #     refute page.has_content?("Slotaitems")
  #   end
  # end
end
