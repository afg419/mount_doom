class ItemsController < ApplicationController
  def index
    @items = Item.available
  end

  def show
    @item = Item.find_by(slug: params[:slug])
  end
end
