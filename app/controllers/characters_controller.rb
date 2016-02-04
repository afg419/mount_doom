class CharactersController < ApplicationController
  before_action :user_logged_in?

  def new
    @character = Character.new
    @avatars = Avatar.all
    render layout: 'wide',  :locals => {:background => "shire"}
  end

  private

  def user_logged_in?
    unless current_user
      redirect_to login_path
      flash[:warning] = "Please log in before selecting character"
    end
  end
end
