require 'test_helper'

class StoreAndCharacterHaveItemsTest < ActionDispatch::IntegrationTest
  test "both stores and characters have their own items" do
    create_start_of_game
    items = create_list(:item, 3)
    items2 = create_list(:item, 3)
    ApplicationController.any_instance.stubs(:in_game).returns(true)
    @store.items = items
    @character.items = items2

    visit store_path(@location, @store)
    # save_and_open_page
    assert page.has_content? "Welcome to the Taylor Rules armory"

    within ".character_selling" do
      assert page.has_content? "Item 4"
      assert page.has_content? "Item 5"
      assert page.has_content? "Item 6"
    end

    within ".store_selling" do
      assert page.has_content? "Item 1"
      assert page.has_content? "Item 2"
      assert page.has_content? "Item 3"
    end

  end
end
