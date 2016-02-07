require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test 'a item must have a name' do
    item = Item.create(price: 10)

    assert_equal 0, Item.all.count
  end

  test 'a item can set its slug' do
    create_shop
    item = Item.find_by(name:"Dang Coconut")
    assert_equal "dang-coconut", item.slug
  end

  test 'a item can send its slug to params' do
    create_shop
    item = Item.find_by(name:"Dang Coconut")
    assert_equal "dang-coconut", item.to_param
  end

  test 'a item can send its description to the right page' do
    create_shop
    item = Item.find_by(name:"Dang Coconut")

    assert_equal "Dang, these are good", item.description_type("show")
    refute_equal "Dang, these are good", item.description_type("index")
  end
end
