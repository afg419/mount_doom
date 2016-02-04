class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_cart
  helper_method :oils, :current_user, :current_admin?, :return_oil_names,
                :set_background, :in_game?, :current_character, :current_avatar,
                :user_logged_in?

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def oils
    Oil.all
  end

  def user_logged_in?
    unless current_user
      redirect_to login_path
      flash[:error] = "Please log in"
    end
  end

  def in_game?
    current_user && session[:in_game]
  end

  def current_character
    @character ||= current_user.character
  end

  def current_avatar
    current_character.avatar
  end

  # def return_oil_names
  #   oil_names = Oil.all.map do |oil|
  #     oil.name
  #   end
  #   oil_names
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
end
