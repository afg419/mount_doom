require 'test_helper'

class RouletteServiceTest < ActiveSupport::TestCase

  def setup
    @character = create(:character)

    @origin_location = @character.location
    @target_location = Location.create(name: "Rivendell", slug: "rivendell")
    @origin_location.update_attribute(:next_location_id, @target_location.id)

    @params = {
      health: "5",
      location_id: "#{@origin_location.id}"
    }
    @r = RouletteService.new(@params, @character)
  end

  test "exists" do
    assert RouletteService
  end

  test "initializes with information from params" do

    assert_equal @origin_location, @r.origin_location
    assert_equal @character, @r.character
    assert_equal 5, @r.health_after_game
    assert_equal @target_location, @r.target_location
  end

  test "generates a wound" do
    assert_equal -5, @r.generate_main_wound.skill_set.health
    puts @r.generate_main_wound.name
  end

  test "generate_random_items" do
    items = @r.generate_random_items
    assert_equal Array, items.class
    items.each do |item|
      assert item.respond_to?(:name)
      assert item.respond_to?(:skill_set)
      assert item.respond_to?(:category)
    end
    assert 0 <= items.length && items.length <= 4
  end

  test "generate_random_wounds" do
    wounds = @r.generate_random_wounds
    assert_equal Array, wounds.class
    wounds.each do |wound|
      assert wound.respond_to?(:name)
      assert wound.respond_to?(:skill_set)
    end

    assert 0 <= wounds.length && wounds.length <= 4
  end


  test "generates_travel_event" do
    assert_equal :success, @r.generate_travel_event
  end

  test "generates_travel_event_and_kills_if_dead" do
    @r.health_after_game = -1
    assert_equal :dead, @r.generate_travel_event
  end
end
