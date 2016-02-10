require "test_helper"

class AdminAvatarsTest < ActionDispatch::IntegrationTest
  test "logged in admin sees avatars index" do
    create_admin
    avatar1 = create(:avatar)
    avatar2 = create(:avatar)

    visit admin_dashboard_index_path
    click_button "Edit Avatars"

    assert_equal admin_avatars_path, current_path
    assert page.has_content?("All Avatars")

    within("#avatar-#{avatar1.id}") do
      assert page.has_content?(avatar1.name)
      assert page.has_content? "strength: 10"
      assert page.has_content? "dexterity: 10"
      assert page.has_content? "intelligence: 10"
      assert page.has_content? "speed: 10"
      assert page.has_content? "health: 10"
      assert page.has_content? "money: 10"
      assert page.has_content? "ACTIVE"
    end

    within("#avatar-#{avatar2.id}") do
      assert page.has_content?(avatar2.name)
      assert page.has_content? "strength: 10"
      assert page.has_content? "dexterity: 10"
      assert page.has_content? "intelligence: 10"
      assert page.has_content? "speed: 10"
      assert page.has_content? "health: 10"
      assert page.has_content? "money: 10"
      assert page.has_content? "ACTIVE"
    end
  end

  test "user does not see admin categories index" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_avatars_path

    refute page.has_content?("All Avatars")
    assert page.has_content?("Start New Game")
  end

  test "guest does not see admin categories index" do
    visit admin_avatars_path

    refute page.has_content?("All Avatars")
    assert page.has_content?("Login")
  end

  test "admin can edit avatar" do
    create_admin
    avatar1 = create(:avatar)
    avatar2 = create(:avatar)

    visit admin_avatars_path

    within("#avatar-#{avatar1.id}") do
      click_button "Edit"
    end

    assert_equal edit_admin_avatar_path(avatar1), current_path

    fill_in "Name", with: "EditedName"
    fill_in "Money", with: 2
    fill_in "Strength", with: 2
    fill_in "Dexterity", with: 2
    fill_in "Intelligence", with: 2
    fill_in "Health", with: 2
    fill_in "Speed", with: 2
    click_button "Update Avatar"

    assert_equal admin_avatars_path, current_path

    within("#avatar-#{avatar1.id}") do
      assert page.has_content? "EditedName"
      assert page.has_content? "strength: 2"
      assert page.has_content? "dexterity: 2"
      assert page.has_content? "intelligence: 2"
      assert page.has_content? "speed: 2"
      assert page.has_content? "health: 2"
      assert page.has_content? "money: 2"
    end
  end

  test "admin can add avatar" do
    create_admin

    visit admin_dashboard_index_path

    click_button "Add New Avatar"

    fill_in "Name", with: "NewAvatar"
    fill_in "Money", with: 20
    fill_in "Strength", with: 2
    fill_in "Dexterity", with: 2
    fill_in "Intelligence", with: 2
    fill_in "Health", with: 2
    fill_in "Speed", with: 2
    click_button "Create Avatar"

    assert admin_dashboard_index_path, current_path

    visit admin_avatars_path

    within("#avatar-#{Avatar.last.id}") do
      assert page.has_content?("NewAvatar")
      assert page.has_content? "strength: 2"
      assert page.has_content? "dexterity: 2"
      assert page.has_content? "intelligence: 2"
      assert page.has_content? "speed: 2"
      assert page.has_content? "health: 2"
      assert page.has_content? "money: 2"
      assert page.has_content? "ACTIVE"
    end
  end

  test "admin can retire an avatar" do
    create_admin
    avatar1 = create(:avatar)

    visit admin_avatars_path

    within("#avatar-#{avatar1.id}") do
      click_button "Retire"
    end

    assert admin_avatars_path, current_path

    within("#avatar-#{avatar1.id}") do
      assert page.has_content? "RETIRED"
      refute page.has_content? "ACTIVE"
    end
  end
end
