require 'test_helper'

class InGameAuthenticationTest < ActionDispatch::IntegrationTest

  # def setup
  #   riv = Location.create(name: "Rivendell", slug: "rivendell", next_location_id: 3)
  #   Location.create(name: "Bree", slug: "bree", next_location_id: riv.id)
  # end

  test "location authentication" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    riv = create(:location, name: "Rivendell", slug: "rivendell")
    @location = create(:location, next_location_id: riv.id)

    visit "/bree"
    visit '/rivendell'
    assert_equal restart_game_path, current_path
  end

  test "location authentication 2" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    riv = create(:location, name: "Rivendell", slug: "rivendell")
    @location = create(:location, next_location_id: riv.id)

    visit "/bree/armory"
    visit '/rivendell/map'
    assert_equal restart_game_path, current_path
  end

  test "location authentication 3" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    riv = create(:location, name: "Rivendell", slug: "rivendell")
    @location = create(:location, next_location_id: riv.id)

    visit "/bree/map"
    visit '/rivendell/apothecary'
    assert_equal restart_game_path, current_path
  end

  test "arriving authentication" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    riv = create(:location, name: "Rivendell", slug: "rivendell")
    @user.character.location = create(:location, next_location_id: riv.id)
    location = @user.character.location

    visit "/bree"
    visit "travel_game?location_id=1"
    assert_equal travel_game_path, current_path
    visit "travel_summary?location_id=#{location.id}&health=12"
    assert_equal travel_summary_path, current_path
    visit '/rivendell'
    assert_equal '/rivendell', current_path
  end

  test "location authentication 4" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)
    riv = create(:location, name: "Rivendell", slug: "rivendell")
    bree = create(:location, next_location_id: riv.id)
    @user.character.location = riv

    visit "/rivendell"
    visit '/bree'
    assert_equal restart_game_path, current_path
  end

  test "location authentication 5" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)
    riv = create(:location, name: "Rivendell", slug: "rivendell")
    bree = create(:location, next_location_id: riv.id)
    @user.character.location = riv

    visit "/rivendell/map"
    visit '/bree/armory'
    assert_equal restart_game_path, current_path
  end

  test "location authentication 6" do

  end

  test "refreshing authentication 1" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    visit '/bree'
    visit "travel_game?location_id=1"
    visit "travel_game?location_id=1"
    assert_equal restart_game_path, current_path
  end

  test "refreshing authentication 2" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    riv = create(:location, name: "Rivendell", slug: "rivendell")
    @user.character.location = create(:location, next_location_id: riv.id)
    location = @user.character.location

    visit "/bree"
    visit "travel_game?location_id=1"
    visit "travel_summary?location_id=#{location.id}&health=12"
    visit "travel_summary?location_id=#{location.id}&health=12"
    assert_equal restart_game_path, current_path
  end

end
