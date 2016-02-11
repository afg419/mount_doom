require 'test_helper'

class TradesControllerTest < ActionController::TestCase

  def setup
    @controller = TradesController.new
  end

  test "create method should update database entries" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    item_skill_set = SkillSet.create(strength: 1,
                                    dexterity: 2,
                                 intelligence: 3,
                                       health: 4,
                                        money: -3,
                                        speed: 6)

    item1 = Item.create(name: "dagger", skill_set: item_skill_set)
    item2 = Item.create(name: "bowling ball", skill_set: item_skill_set)
    item3 = Item.create(name: "basket", skill_set: item_skill_set)
    @character.items << [item1, item2]
    @store.items << item3

    params = {
              "classes"=>
                {
                  "0"=>
                    ["collection-item avatar item player-item-#{item1.id} show",
                     "collection-item avatar item player-item-#{item2.id} show"],
                  "1"=>
                    ["collection-item avatar item store-item-#{item3.id} show"]
                },
              "store_id"=>"#{@store.id}",
              "total"=>"3",
              "controller"=>"trades",
              "action"=>"create"
            }

    post(:create, params)

    @character.reload
    @store.reload
    assert_equal 13, @character.money
    assert_equal ["basket"], @store.items.map{|item| item.name}
    assert_equal ["basket"], @character.items.map{|item| item.name}
    refute Item.find_by(name: "dagger")
  end

  test "create method should update database entries when only buying or selling" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    item_skill_set = SkillSet.create(strength: 1,
                                    dexterity: 2,
                                 intelligence: 3,
                                       health: 4,
                                        money: -3,
                                        speed: 6)

    item1 = Item.create(name: "dagger", skill_set: item_skill_set)
    item2 = Item.create(name: "bowling ball", skill_set: item_skill_set)
    item3 = Item.create(name: "basket", skill_set: item_skill_set)
    @character.items << [item1, item2]
    @store.items << item3

    params = {
              "classes"=>
                {
                  "0"=>
                    ["collection-item avatar item player-item-#{item1.id} show",
                     "collection-item avatar item player-item-#{item2.id} show"]
                },
              "store_id"=>"#{@store.id}",
              "total"=>"6",
              "controller"=>"trades",
              "action"=>"create"
            }

    post(:create, params)

    @character.reload
    @store.reload
    assert_equal 16, @character.money
    assert_equal ["basket"], @store.items.map{|item| item.name}
    assert_equal [], @character.items.map{|item| item.name}
  end

  test "create method should update incidents " do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    item_skill_set = SkillSet.create(strength: 1,
                                    dexterity: 2,
                                 intelligence: 3,
                                       health: 4,
                                        money: -3,
                                        speed: 6)

    item1 = Item.create(name: "dagger", skill_set: item_skill_set)
    incident = Incident.create(name: "spider bite", skill_set: item_skill_set)
    item3 = Item.create(name: "basket", skill_set: item_skill_set)
    @character.items << item1
    @character.incidents << incident
    @store.items << item3

    params = {
              "classes"=>
                {
                  "0"=>
                    ["collection-item avatar item player-item-#{item1.id} show",
                     "collection-item avatar item incident-item-#{incident.id} show"]
                },
              "store_id"=>"#{@store.id}",
              "total"=>"0",
              "controller"=>"trades",
              "action"=>"create"
            }

    post(:create, params)

    @character.reload
    @store.reload
    assert_equal 10, @character.money
    assert_equal ["basket"], @store.items.map{|item| item.name}
    assert_equal [], @character.incidents.map{|incident| incident.name}
    assert_equal [], @character.items.map{|item| item.name}
  end
end
