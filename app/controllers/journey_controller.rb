class JourneyController < ApplicationController
  include JourneyHelper
  before_action :still_alive?, except: [:restart]

  before_action :journey_authorize!

  def location_permission
    @location_permission ||= LocationService.new(current_user)
  end

  def authorize?
    location_permission.allow?(params[:controller], params[:action], last_visited)
  end


  def show
    @location = Location.where(slug: params[:slug]).includes(:stores)[0]
    current_character.location = @location
    current_character.save
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
    @location = Location.find(params[:location_id])
    @event_generator = RouletteService.new(params, current_character)
    status = @event_generator.generate_travel_event
    render layout: 'wide',  :locals => {:background => 'start', status: status}
  end

  def map
    render layout: 'wide', :locals => {:background => "map_#{params[:slug]}"}
  end

  def game
    @location_id = params[:location_id]
    render "journey/game#{@location_id}.html.erb"
  end

  def restart
    @status = status
    if @status
      session[:in_game] = nil
      current_character.user_id = nil
      render layout: 'wide',  :locals => {:background => "restart-#{session[:alive]}"}
    else
      redirect_to root_path
    end
  end

  def still_alive?
    if current_character.hp > 0
      session[:alive] = true
    else
      session[:alive] = false
      redirect_to restart_game
    end
  end

  def help
    render layout: 'wide',  :locals => {:background => "granite"}
  end
end
