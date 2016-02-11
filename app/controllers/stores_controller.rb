class StoresController < ApplicationController
  before_action :current_location_is_slug_location_for_store?

  def show
    location = Location.find_by(slug: params[:location_slug])
    store_type = params[:slug]
    @store = location.send(store_type)
    @character_items = current_character.items.where(category: @store.category.id)

    render layout: 'wide',  :locals => {:background => store_type}
  end

  private

  def current_location_is_slug_location_for_store?
    unless current_character.location.slug == params[:location_slug]
      session[:alive] = false
      flash[:error] = "Don't Cheat!"
      redirect_to restart_game_path
    end
  end
end
