class TradesController < ApplicationController
  def create
    store = Store.find(params["store_id"])
    trader = TransactionService.new(current_character, store, params["total"])
    trader.collect_items(params["classes"])
    trader.execute_transaction
    store.save
    redirect_to current_character
  end
end
