require 'test_helper'

class MapTest < ActionDispatch::IntegrationTest
  test "game navbar has button to map" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)

    visit journey_path(@location)

    within ".right" do
      click_on "Map"
    end
    assert_equal "/#{@location.slug}/map", current_path

  end
end
