require 'test_helper'

class UserCanGoToNextTownTest < ActionDispatch::IntegrationTest
  test "User can go to next page" do
    skip
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns("true")
    riv = Location.create(name: "Rivendell", slug: "rivendell" )
    @character.location = @location
    @location.update_attribute(:next_location_id, riv.id)
    @location.save

    visit journey_path(@location)

    click_on "Travel to Next Location"

    assert_equal travel_summary_path, current_path

    click_on "Continue"

    assert_equal journey_path(@location.next_location), current_path
  end
end
