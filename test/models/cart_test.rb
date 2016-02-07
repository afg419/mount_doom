require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "a cart can be initialized without data" do
    @cart = Cart.new(nil)
    assert_equal({}, @cart.contents)
  end

  test "a cart can be initialized with a item" do
    item = create_item("Slotaitem", 6.99, "yummy")
    create_cart(item)
    assert_equal({ item.id.to_s => 1 }, @cart.contents)
  end

  test "a item can be added to the cart" do
    item1 = create_item("Slotaitem", 6.99, "yummy")
    item2 = create_item("Doritos", 2.99, "cheesy")
    create_cart(item1)

    assert_equal({ item1.id.to_s => 1 }, @cart.contents)

    @cart.add_item(item2.id.to_s)

    assert_equal({ item1.id.to_s => 1, item2.id.to_s => 1 }, @cart.contents)
  end

  test "a item can be removed from the cart" do
    create_two_item_cart
    @cart.add_item(@item2.id.to_s)

    assert_equal({ @item1.id.to_s => 1, @item2.id.to_s => 2 }, @cart.contents)

    @cart.subtract_item(@item2.id.to_s)

    assert_equal({ @item1.id.to_s => 1, @item2.id.to_s => 1 }, @cart.contents)
  end

  test "if removing a item from the cart makes the quantity zero, it is removed fro the cart" do
    create_two_item_cart

    assert_equal({ @item1.id.to_s => 1, @item2.id.to_s => 1 }, @cart.contents)

    @cart.subtract_item(@item2.id.to_s)

    assert_equal({ @item1.id.to_s => 1 }, @cart.contents)
  end

  test "cart can return it contents, quantity and subtotal of each item" do
    create_two_item_cart
    cart_item = @cart.cart_items

    assert_equal "Slotaitem", cart_item[0].name
    assert_equal 1, cart_item[0].quantity
    assert_equal 6.99, cart_item[0].subtotal
    assert_equal "Doritos", cart_item[1].name
    assert_equal 1, cart_item[1].quantity
    assert_equal 2.99, cart_item[1].subtotal
  end

  test "cart can return the total price of all it's items" do
    create_two_item_cart

    assert_equal 9.98, @cart.total
  end

  test "cart can return the total number of items it contains" do
    create_two_item_cart
    assert_equal 2, @cart.cart_size
  end

  test "cart can return how many of each item it has" do
    create_two_item_cart
    @cart.add_item(@item2.id.to_s)

    assert_equal 1, @cart.count_of(@item1.id.to_s)
    assert_equal 2, @cart.count_of(@item2.id.to_s)
  end

  test "the cart can be emptied" do
    create_two_item_cart
    assert_equal({}, @cart.clear)
  end
end
