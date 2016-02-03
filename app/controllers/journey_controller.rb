class JourneyController < ApplicationController
  def show
    if in_game?
      render layout: 'wide',  :locals => {:background => params[:slug]}
    else
      flash[:error] = "Login and join a game first!"
      redirect_to root_path
    end
  end

  def create
    current_user.character = Character.create(avatar_id: params[:avatar])
    session[:in_game] = true
    redirect_to journey_path("bree")
  end

  def destroy
    session[:in_game] = nil
    redirect_to user_path(current_user)
  end
end
