require 'test_helper'

class StoreAndCharacterHaveItemsTest < ActionDispatch::IntegrationTest
  test "both stores and characters have their own items" do
    skip
    create_start_of_game
    items = create_list(:item, 6)
    items1 = items[0..2]
    items2 = items[3..-1]
    ApplicationController.any_instance.stubs(:in_game).returns(true)
    @character.items = items2
    @store.items = items1

    visit store_path(@location, @store)
    save_and_open_page
    assert page.has_content? "Welcome to the Taylor Rules armory"

    within ".character_selling" do
      assert page.has_content? "Item 1"
      assert page.has_content? "Item 2"
      assert page.has_content? "Item 3"
    end

    within ".store_selling" do
      assert page.has_content? "Item 1"
      assert page.has_content? "Item 2"
      assert page.has_content? "Item 3"
    end

  end
end
