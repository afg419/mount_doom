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
    session[:in_game] = true
    redirect_to journey_path("bree")
  end
end
