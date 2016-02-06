require 'test_helper'

class UserWithPriorGameCanContinueTest < ActionDispatch::IntegrationTest
  test "user can continue prior game" do
    bree = Location.create(name: "Bree", slug: "bree")
    user = create_user
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    skills = SkillSet.create(intelligence: 4, dexterity: 3, strength: 3, health: 3, money: 100, speed: 2)
    avatar = Avatar.create(name: "Taylor", image_url:"jojoj", skill_set: skills)
    character = Character.create(user: user, avatar: avatar, location: bree)

    visit user_path(user)

    click_on "Continue"

    assert_equal journey_path(bree), current_path

  end
end
