require "test_helper"

class AdminStoresTest < ActionDispatch::IntegrationTest
  test "logged in admin sees stores index" do
    create_admin_and_stores_with_inventory

    visit admin_dashboard_index_path

    click_button "Edit Store Inventory/Add Items"

    assert_equal admin_stores_path, current_path
    assert page.has_content?("All Stores")

    within("#store-#{@store1.id}") do
      assert page.has_content?(@store1.name)
    end

    within("#store-#{@store2.id}") do
      assert page.has_content?(@store2.name)
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

  test "admin can see a store's inventory" do
    create_admin_and_stores_with_inventory

    visit edit_admin_store_path(@store1.id)

    within("#item-#{@item1.id}") do
      assert page.has_content?(@item1.name)
      assert page.has_content?(@item1.price)
    end

    within("#item-#{@item2.id}") do
      assert page.has_content?(@item2.name)
      assert page.has_content?(@item2.price)
    end

    refute page.has_content?(@item3.name)
  end

  test "admin can add item to a store" do
    create_admin_and_stores_with_inventory

    visit admin_stores_path

    within("#store-#{@store1.id}") do
      click_button "Edit Inventory"
    end

    assert_equal edit_admin_store_path(@store1.id), current_path

    click_link "Add New Item"

    fill_in "Name", with: "NewItem"
    fill_in "Money", with: 20
    fill_in "Strength", with: 2
    fill_in "Dexterity", with: 2
    fill_in "Intelligence", with: 2
    fill_in "Health", with: 2
    fill_in "Speed", with: 2
    click_button "Create Item"

    assert_equal edit_admin_store_path(@store1.id), current_path

    visit edit_admin_store_path(@store1.id)

    assert page.has_content?("NewItem")
    assert page.has_content? "strength: 2"
    assert page.has_content? "dexterity: 2"
    assert page.has_content? "intelligence: 2"
    assert page.has_content? "speed: 2"
    assert page.has_content? "health: 2"
    assert page.has_content? "money: 2"

    assert_equal Item.last.category.name, @store1.category.name
  end

  test "admin can edit item" do
    create_admin_and_stores_with_inventory

    visit edit_admin_store_path(@store1.id)

    within("#item-#{@item1.id}") do
      click_button "Edit"
    end

    assert_equal edit_admin_item_path(@item1), current_path

    fill_in "Name", with: "EditedName"
    fill_in "Money", with: 2
    fill_in "Strength", with: 2
    fill_in "Dexterity", with: 2
    fill_in "Intelligence", with: 2
    fill_in "Health", with: 2
    fill_in "Speed", with: 2
    click_button "Update Item"

    assert_equal edit_admin_store_path(@store1.id), current_path

    within("#item-#{@item1.id}") do
      assert page.has_content?("EditedName")
      assert page.has_content? "strength: 2"
      assert page.has_content? "dexterity: 2"
      assert page.has_content? "intelligence: 2"
      assert page.has_content? "speed: 2"
      assert page.has_content? "health: 2"
      assert page.has_content? "money: 2"
    end

    assert_equal @item1.category.name, @store1.category.name
  end

  test "admin can delete item" do
    create_admin_and_stores_with_inventory

    visit edit_admin_store_path(@store1.id)

    within("#item-#{@item1.id}") do
      click_link "Delete"
    end

    assert edit_admin_store_path(@store1.id), current_path

    refute page.has_content?(@item1.name)
  end

end
