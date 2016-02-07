require "test_helper"

class ItemTest < ActiveSupport::TestCase
  should belong_to :itemable
  should belong_to :skill_set

  test 'a item must have a name' do
    item = Item.create(price: 10)

    assert_equal 0, Item.all.count
  end

  test 'a item can send its description to the right page' do
    skip
    create_shop
    item = Item.find_by(name:"Dang Coconut")

    assert_equal "Dang, these are good", item.description_type("show")
    refute_equal "Dang, these are good", item.description_type("index")
  end
end
