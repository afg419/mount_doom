class CartItemsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "Added #{view_context.link_to(item.name, item_path(item.slug))} to cart."
    redirect_to items_path
  end

  def index
    @items = @cart.cart_items
  end

  def update
    item = Item.find(params[:id])
    @cart.add_or_subtract_item(params[:edit_action], item)
    if @cart.remove_notice?(params[:edit_action])
      flash[:notice] = "Successfully removed #{view_context.link_to(item.name, item_path(item.slug))} from your cart."
    end
    @items = @cart.cart_items
    redirect_to cart_items_path
  end

  def destroy
    item = Item.find(params[:id])
    @cart.remove_item_completely(item.id)
    flash[:notice] = "Successfully removed #{view_context.link_to(item.name, item_path(item.slug))} from your cart."
    redirect_to cart_items_path
  end
end
