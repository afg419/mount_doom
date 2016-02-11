class PermissionService
  extend Forwardable

  attr_reader :user, :controller, :action, :location, :previous_location
  def_delegators :user, :platform_admin?

  def initialize(user)
    @user = user
    @location = user.character.location
    @previous_location = Location.find_by(next_location_id: @location.id)
  end

  def allow?(controller, action, last_visited)
    @last_visited = last_visited
    @controller = controller
    @action = action

    case last_visited
    when location.name then within_town_permissions
    when previous_location.name then arriving_to_town_permissions
    else
      travelling_permissions
    end
  end

private

  def within_town_permissions
    return true if controller == "journey" && action.in?(%w{ map show continue
                                                             create destroy
                                                             game help })
    return true if controller == "stores" && action.in?(%w{ show })
    return true if controller == "trades" && action.in?(%w{ create })
  end

  def arriving_to_town_permissions

  end

  def travelling_permissions

  end

    #
  # def logged_in_in_game_permissions
  #   return [:ok, true] if controller == "characters" && action.in?(%w{ show update create })
  #   return [:ok, true] if controller == "stores"
  #   return [:ok, true] if controller == "trades" && action.in?(%w{ create })
  #   return [:ok, true] if controller == "journey" && action.in?(%w{ show
  #                                                                   destroy
  #                                                                   summary
  #                                                                   game
  #                                                                   map
  #                                                                   help })
  #   [:current_character, false, "Please Save and Quit"]
  # end
end
