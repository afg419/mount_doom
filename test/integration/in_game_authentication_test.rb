require 'test_helper'

class InGameAuthenticationTest < ActionDispatch::IntegrationTest

  def setup
    riv = Location.create(name: "Rivendell", slug: "rivendell", next_location_id: 3)
    Location.create(name: "Bree", slug: "bree", next_location_id: riv.id)
  end

  # test "location authentication" do
  #   bree_routes = ['/bree', '/bree/armory', '/bree/map']
  #   rivendell_routes = ['/rivendell', '/rivendell/armory', '/rivendell/map']
  #
  #   create_start_of_game
  #   ApplicationController.any_instance.stubs(:in_game).returns(true)
  #
  #   bree_routes.each do |bree_route|
  #     rivendell_routes.each do |rivendell_route|
  #       visit '/bree'
  #       visit bree_route
  #       assert_equal bree_route, current_path
  #       visit rivendell_route
  #       assert_equal restart_game_path, current_path
  #
  #       create_start_of_game
  #       ApplicationController.any_instance.stubs(:in_game).returns(true)
  #     end
  #   end
  # end

  test "arriving authentication" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)
    ApplicationController.any_instance.stubs(:last_visited).returns("bree")

    visit "/bree"
    visit "travel_game?location_id=1"
    assert_equal travel_game_path, current_path
    visit "travel_summary?location_id=#{@location.id}&health=12"
    assert_equal travel_summary_path, current_path
    visit '/rivendell'
    assert_equal '/rivendell', current_path
  end

  # test "journeying authentication 1" do
  #   bree_routes = ['/bree', '/bree/armory', '/bree/map']
  #   rivendell_routes = ['/rivendell', '/rivendell/armory', '/rivendell/map']
  #
  #   bree_routes.each do |bree_route|
  #     create_start_of_game
  #     ApplicationController.any_instance.stubs(:in_game).returns(true)
  #
  #     visit '/bree'
  #     visit "travel_game?location_id=#{@location.id}s"
  #
  #     visit bree_route
  #     assert_equal restart_game_path, current_path
  #   end
  # end
  #
  # test "journeying authentication 2" do
  #   bree_routes = ['/bree', '/bree/armory', '/bree/map']
  #   rivendell_routes = ['/rivendell', '/rivendell/armory', '/rivendell/map']
  #
  #   rivendell_routes.each do |rivendell_route|
  #     create_start_of_game
  #     ApplicationController.any_instance.stubs(:in_game).returns(true)
  #
  #     visit '/bree'
  #     visit "travel_game?location_id=#{@location.id}s"
  #     visit rivendell_route
  #
  #     assert_equal restart_game_path, current_path
  #   end
  # end
  #
  # test "refreshing authentication 1" do
  #   create_start_of_game
  #   ApplicationController.any_instance.stubs(:in_game).returns(true)
  #
  #   visit '/bree'
  #   visit "travel_game?location_id=#{@location.id}s"
  #   visit "travel_game?location_id=#{@location.id}s"
  #   assert_equal restart_game_path, current_path
  # end
  #
  # test "refreshing authentication 2" do
  #   create_start_of_game
  #   ApplicationController.any_instance.stubs(:in_game).returns(true)
  #
  #   visit '/bree'
  #   visit "travel_game?location_id=#{@location.id}s"
  #   visit "travel_summary?location_id=#{@location.id}&health=12"
  #   visit "travel_summary?location_id=#{@location.id}&health=12"
  #   assert_equal restart_game_path, current_path
  # end

end
