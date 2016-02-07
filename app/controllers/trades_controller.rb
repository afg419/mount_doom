class TradesController < ApplicationController
  def create
    sold = params["classes"]["0"]
    bought = params["classes"]["1"]
    total = params["total"].to_i
    store = Store.find(params["store_id"])

    sold_items = trade_param_to_item(sold)
    bought_items = trade_param_to_item(bought)

    current_character.items += bought_items
    current_character.items -= sold_items
    current_character.save

    store.items += sold_items
    store.items -= bought_items
    store.save

    redirect_to current_character
  end

private

  def trade_param_to_item(trade_array)
    trade_array.map do |trade|
      Item.find(trade.split("-item-").last.split(" show")[0].to_i)
    end
  end


  # params = {
  #           "classes"=>
  #             {
  #               "0"=>
  #                 ["collection-item avatar item player-item-1 show",
  #                  "collection-item avatar item player-item-2 show"],
  #               "1"=>
  #                 ["collection-item avatar item store-item-3 show"]
  #             },
  #           "total"=>"15",
  #           "controller"=>"trades",
  #           "action"=>"create"
  #         }

end
