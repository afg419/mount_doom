class StoresController < ApplicationController
  before_action :current_location_is_slug_location?

  def show
    location = Location.find_by(slug: params[:location_slug])
    store_type = params[:slug]
    @store = location.send(store_type)
    @character_items = current_character.items.where(category: @store.category.id)

    render layout: 'wide',  :locals => {:background => store_type}
  end

private

  def current_location_is_slug_location?
    unless current_character.location.slug == params[:location_slug]
      session[:alive] = nil
      flash[:error] = "Don't Cheat!"
      redirect_to restart_game_path
    end
  end
end
