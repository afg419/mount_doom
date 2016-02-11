class PermissionService
  extend Forwardable

  attr_reader :user, :controller, :action, :in_game
  def_delegators :user, :platform_admin?

  def initialize(user)
    @user = user
  end

  def allow?(controller, action, in_game)
    @in_game = in_game
    @controller = controller
    @action = action
    case
    when user && platform_admin?        then platform_admin_permissions
    when user && in_game        then logged_in_in_game_permissions
    when user && !in_game       then logged_in_no_game_permissions
    else
      logged_out_no_game_permissions
    end
  end

private

  def platform_admin_permissions
    return [:ok, true] if controller == "admin/dashboard"
    return [:ok, true] if controller == "admin/items"
    return [:ok, true] if controller == "admin/avatars"
    return [:ok, true] if controller == "admin/stores"
    return [:ok, true] if controller == "sessions"
    return [:ok, true] if controller == "pages"
    [:login_path, false, "Not Accessible As Admin"]
  end

  def logged_out_no_game_permissions
    return [:ok, true] if controller == "sessions" && action.in?(%w{ new create })
    return [:ok, true] if controller == "pages"
    return [:ok, true] if controller == "users" && action.in?(%w{ new create })
    [:login_path, false, "Please Login"]
  end

  def logged_in_no_game_permissions
    return [:ok, true] if controller == "sessions" && action.in?(%w{ destroy })
    return [:ok, true] if controller == "pages"
    return [:ok, true] if controller == "characters" && action.in?(%w{ new })
    return [:ok, true] if controller == "users" && action.in?(%w{ show })
    return [:ok, true] if controller == "journey" && action.in?(%w{ create continue })
    [:current_user, false, "Please Start a Game"]
  end

  def logged_in_in_game_permissions
    return [:ok, true] if controller == "characters" && action.in?(%w{ show update create })
    return [:ok, true] if controller == "stores"
    return [:ok, true] if controller == "trades" && action.in?(%w{ create })
    return [:ok, true] if controller == "journey" && action.in?(%w{ show
                                                                    destroy
                                                                    summary
                                                                    game
                                                                    map
                                                                    })
    [:current_character, false, "Please Save and Quit"]
  end
end
