require "test_helper"

class AdminStoresTest < ActionDispatch::IntegrationTest
  test "logged in admin sees stores index" do
    create_admin
    store1 = create(:store)
    store2 = create(:store)

    visit admin_dashboard_index_path

    click_button "Edit Store Inventory/Add Items to Stores"

    assert_equal admin_stores_path, current_path
    assert page.has_content?("All Stores")

    within("#store-#{store1.id}") do
      assert page.has_content?(store1.name)
    end

    within("#store-#{store2.id}") do
      assert page.has_content?(store2.name)
    end
  end

  test "user does not see admin categories index" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_stores_path

    refute page.has_content?("All Stores")
    assert page.has_content?("Start New Game")
  end

  test "guest does not see admin categories index" do
    visit admin_stores_path

    refute page.has_content?("All Stores")
    assert page.has_content?("Login")
  end

  test "admin can add item to a store" do
    create_admin
    item1 = create(:item)
    item2 = create(:item)
    store1 = create(:store)
    store2 = create(:store)
    store1.items << [item1, item2]

    visit admin_stores_path

    within("#store-#{store1.id}") do
      click_button "Edit Inventory"
    end

    assert_equal edit_admin_store_path(store1.id), current_path

    click_button "Add New Item"

    fill_in "Name", with: "NewItem"
    fill_in "Money", with: 20
    fill_in "Strength", with: 2
    fill_in "Dexterity", with: 2
    fill_in "Intelligence", with: 2
    fill_in "Health", with: 2
    fill_in "Speed", with: 2
    click_button "Create Item"

    assert admin_dashboard_index_path, current_path

    visit admin_items_path

    assert page.has_content?("NewItem")
    assert page.has_content? "strength: 2"
    assert page.has_content? "dexterity: 2"
    assert page.has_content? "intelligence: 2"
    assert page.has_content? "speed: 2"
    assert page.has_content? "health: 2"
    assert page.has_content? "money: 2"
  end

  test "admin can see a store's inventory" do
    create_admin
    item1 = create(:item, name: "This is an Item")
    item2 = create(:item)
    item3 = create(:item, name: "Item Not In Inventory")
    store1 = create(:store)
    store1.items << [item1, item2]

    visit edit_admin_store_path(store1.id)
save_and_open_page
    within("#item-#{item1.id}") do
      assert page.has_content?(item1.name)
      assert page.has_content?(item1.price)
    end

    within("#item-#{item2.id}") do
      assert page.has_content?(item2.name)
      assert page.has_content?(item2.price)
    end

    refute page.has_content?(item3.name)
  end

end
