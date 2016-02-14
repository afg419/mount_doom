class JourneyController < ApplicationController
  include JourneyHelper

  before_action :current_location_is_slug_location?, only: [:show, :map]
  before_action :still_alive?, except: [:create, :restart]

  def show
    session[:summarizing] = nil
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
    session[:gaming] = nil

    if session[:summarizing]
      dont_cheat(:summarizing)
    else
      session[:summarizing] = true
      progress_to_next_location
      @event_generator = RouletteService.new(params, current_character)
      status = @event_generator.generate_travel_event
      render layout: 'wide',  :locals => {:background => 'start', status: status}
    end
  end

  def map
    render layout: 'wide', :locals => {:background => "map_#{params[:slug]}"}
  end

  def game
    if session[:gaming]
      dont_cheat(:gaming)
    else
      session[:gaming] = true
      @location_id = params[:location_id]
      render "journey/game#{@location_id}.html.erb"
    end
  end

  def restart
    @status = status
    session[:in_game] = nil
    current_character.user_id = nil
    current_character.save
    render layout: 'wide',  :locals => {:background => "restart-#{session[:alive]}"}
  end

  def help
    render layout: 'wide',  :locals => {:background => "granite"}
  end
private

  def progress_to_next_location
    @location = Location.find(params[:location_id])
    current_character.location_id = @location.next_location_id
    current_character.save
  end

  def dont_cheat(page_key)
    session[page_key] = nil
    session[:alive] = nil
    flash[:error] = "Don't Cheat!"
    redirect_to restart_game_path
  end

  def still_alive?
    if current_character.hp > 0
      session[:alive] = true
    else
      session[:alive] = false
      redirect_to restart_game_path
    end
  end

end
