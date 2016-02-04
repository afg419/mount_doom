class JourneyController < ApplicationController
  before_action :in_game?, only: [:show]
  def show
    render layout: 'wide',  :locals => {:background => params[:slug]}
  end

  def continue
    session[:in_game] = true
    redirect_to journey_path("bree")
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
