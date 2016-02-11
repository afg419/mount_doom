class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize!


  helper_method :categories, :current_user, :current_admin?,
                :in_game, :current_character, :current_avatar,
                :journey_map_path, :status

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def authorize?
    current_permission.allow?(params[:controller], params[:action],in_game)
  end

  def journey_map_path(location)
    "/#{location.slug}/map"
  end

  def authorize!
    permitted = authorize?
    unless permitted[1]
      flash[:error] = permitted[2]
      redirect_to send(permitted[0])
    end
  end

  def in_game
    session[:in_game]
  end

  def status
    session[:alive]
  end

  def current_character
    @character ||= current_user.character
  end

  def current_avatar
    current_character.avatar
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_current_user
    render file: "/public/404" unless current_user
  end

  def current_admin?
    current_user && current_user.platform_admin?
  end

  def categories
    Category.all
  end
end
