class TradesController < ApplicationController
  def create
    store = Store.find(params["store_id"])
    trader = TransactionService.new(current_character, store)
    trader.collect_items(params["classes"])
    trader.execute_transaction
    store.save
    current_character.save

    redirect_to current_character
  end
end
