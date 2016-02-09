class StoresController < ApplicationController
  def show
    location = Location.find_by(slug: params[:location_slug])
    store_type = params[:slug]
    @store = location.send(store_type)
    @character_items = current_character.items.where(category: @store.category.id)

    render layout: 'wide',  :locals => {:background => store_type}
  end
end
