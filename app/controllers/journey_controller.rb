class JourneyController < ApplicationController
  include JourneyHelper

  def show
    @location = Location.where(slug: params[:slug]).includes(:stores)[0]
    render layout: 'wide',  :locals => {:background => params[:slug]}
  end

  def continue
    session[:in_game] = true
    redirect_to journey_path(current_character.location)
  end

  def create
    bree = Location.find_by(slug: "bree")
    current_user.character = Character.create(avatar_id: params[:avatar], location: bree)
    add_start_items
    session[:in_game] = true
    redirect_to journey_path(bree)
  end

  def destroy
    session[:in_game] = nil
    redirect_to user_path(current_user)
  end

  def summary
    #params = {location_id: where we came from, health_after_game: 6}
    @location = Location.find(params[:location_id])
    status = RouletteService.new(params).generate_travel_event

    case status
    when :dead
    when :success
      render layout: 'wide',  :locals => {:background => 'bree'}
    end
  end
end
