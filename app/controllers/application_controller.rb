class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart
  before_action :authorize!

  helper_method :categories, :current_user, :current_admin?, :return_category_names,
                :set_background, :in_game, :current_character, :current_avatar,
                :user_logged_in?, :render_item_name_or_button_to_equip


  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def render_item_name_or_button_to_equip(item)
    display = item.category.name

    case item.category.name
    when "blacksmith" then "link_to('Equip weapon: ' + display, root_path)"
    when "armory" then "link_to('Equip armor: ' + display, root_path)"
    else
      display
    end
  end

  def authorize!
    permitted = authorize?
    unless permitted[1]
      flash[:error] = permitted[2]
      redirect_to send(permitted[0])
    end
  end

  def authorize?
    current_permission.allow?(params[:controller], params[:action],in_game)
  end

  def user_logged_in?
    unless current_user
      redirect_to login_path
      flash[:error] = "Please log in"
    end
  end

  def in_game
    session[:in_game]
  end

  def current_character
    @character ||= current_user.character
  end

  def current_avatar
    current_character.avatar
  end

  # def return_category_names
  #   category_names = Category.all.map do |category|
  #     category.name
  #   end
  #   category_names
  # end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_current_user
    render file: "/public/404" unless current_user
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def categories
    Category.all
  end
end
