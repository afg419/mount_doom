ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "capybara/rails"
require "mocha/mini_test"
require "simplecov"

SimpleCov.start("rails")

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  def create_start_of_game
    @character = create(:character) #creates character with user, avatar, skillset
    @store = create(:store) #creates store with location and category
    @user = @character.user
    @location = @store.location
    ApplicationController.any_instance.stubs(:current_user).returns(@user)
  end

  def create_character_with_many_items(character)
    blacksmith = Category.create(name: "blacksmith")
    armory = Category.create(name: "armory")
    apothecary = Category.create(name: "apothecary")
    inn = Category.create(name: "inn")

    weapon_ss = SkillSet.create(strength: 1, money: -2)
    armor_ss = SkillSet.create(speed: -1)
    apothecary_ss = SkillSet.create(health: 1)
    inn_ss = SkillSet.create(intelligence: 1)

    @sword = character.items.create(name: "sword1", category: blacksmith, skill_set: weapon_ss)
    @sword2 = character.items.create(name: "sword2", category: blacksmith, skill_set: weapon_ss )
    @armor = character.items.create(name: "armor1", category: armory, skill_set: armor_ss )
    character.items.create(name: "salve1", category: apothecary, skill_set: apothecary_ss )
    character.items.create(name: "salve2", category: apothecary, skill_set: apothecary_ss )
    character.items.create(name: "salve3", category: apothecary, skill_set: apothecary_ss )
    character.items.create(name: "food1", category: inn, skill_set: inn_ss )
  end


  def create_user
    User.create(username: "John", password: "Password", role: 0)
  end

  def create_shop
    category_1 = Category.create(name: "Lard")
    category_2 = Category.create(name: "Coconut Category")
    Item.create(name: "Slotaitems", price: 20,
                category_id: category_1.id)
    Item.create(name: "Dang Coconut", price: 17,
                category_id: category_2.id)
    Item.create(name: "Old Items", price: 20,
                category_id: category_1.id)
  end

  def create_item(name, price)
    Item.create(name: name, price: price,
                )
  end

  def create_cart(item)
    @cart = Cart.new( { item.id.to_s => 1 } )
  end

  def create_two_item_cart
    @item1 = create_item("Slotaitem", 6.99, "yummy")
    @item2 = create_item("Doritos", 2.99, "cheesy")
    create_cart(@item1)
    @cart.add_item(@item2.id.to_s)
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  def teardown
    reset_session!
  end

  def create_item(name, price)
    Item.create(name: name, price: price)
  end

  def create_user(name = "John", password = "Password")
    User.create(username: name, password: password, role: 0)
  end


  def create_cart_for_visitor
    visit items_path
    within("#slotaitems") do
      click_button "Add to Cart"
    end
  end

  def create_admin
    @user = create(:user, username: "admin", role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(@user)
  end

  def create_start_of_game
    @store = create(:store) #creates store with location and category
    @character = create(:character) #creates character with user, avatar, skillset
    @user = @character.user
    @location = @store.location
    ApplicationController.any_instance.stubs(:current_user).returns(@user)
  end

  def create_admin_and_stores_with_inventory
    create_admin
    @item1 = create(:item, name: "Item1")
    @item2 = create(:item, name: "Item2")
    @item3 = create(:item, name: "Item3")
    @store1 = create(:store)
    @store2 = create(:store)
    @store1.items << [@item1, @item2]
    @store2.items << [@item3]
  end

  def login_user(name = "John", password = "Password")
    visit login_path

    fill_in "Username", with: name
    fill_in "Password", with: password
    click_button "Login"
  end

  def login_admin
    visit "/"
    within(".right") do
      click_link "Login"
    end
    fill_in "Username", with: "admin"
    fill_in "Password", with: "password"
    click_button "Login"
  end

  def create_shop
    category_1 = Category.create(name: "Lard")
    category_2 = Category.create(name: "Coconut Category")
    Item.create(name: "Slotaitems",
                 category_id: category_1.id)
    Item.create(name: "Dang Coconut",
                category_id: category_2.id)
    Item.create(name: "Old Items",
                 category_id: category_1.id)
  end

  def create_shop_and_logged_in_user
    create_shop
    user = create_user
    order = user.orders.create(total_price: 20)
    order.item_orders.create(item_id: Item.all.first.id,
                             quantity: 1, subtotal: 20)
    order.item_orders.create(item_id: Item.all.last.id,
                             quantity: 1, subtotal: 20)

    login_user

    visit orders_path
    click_link("View Order Details")
  end

  def create_order(status, price, user_id)
    Order.create(status: status, total_price: price, user_id: user_id)
  end
end

DatabaseCleaner.strategy = :transaction

class Minitest::Spec
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
