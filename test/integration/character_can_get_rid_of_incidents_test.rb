require 'test_helper'

class CharacterCanGetRidOfIncidentsTest < ActionDispatch::IntegrationTest
  test "character can go to show page and use items to relieve incidents" do
    create_start_of_game
    ApplicationController.any_instance.stubs(:in_game).returns(true)
    item = create(:item)
    skill_set = SkillSet.create(strength: 0, defense: 0, intelligence: 0,
                                dexterity: 0, health: -4,
                                speed: 0, money: 0)
    incident = Incident.create(name: "Snake bite", label: "poison", skill_set: skill_set)
    @character.items << item
    @character.incidents << incident
    @character.save

    visit character_path(@character)

    assert page.has_content?("Snake bite")
    assert page.has_content?("Item 1")
    within(".aggregate-stats") do
      assert page.has_content?("Health: 16")
    end

    click_on "Use Items to Cure Injuries"

    assert_equal character_path(@character), current_path
    @character.reload

    visit character_path(@character)

    refute page.has_content?("Item 1")
    refute page.has_content?("Snake bite")

    within(".aggregate-stats") do
      assert page.has_content?("Health: 10")
    end
  end
end
