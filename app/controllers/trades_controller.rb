class TradesController < ApplicationController
  def create
    trader = TransactionService.new(current_character,
                              Store.find(params["store_id"]))
    trader.collect_items(params["classes"])
    trader.execute_transaction
    
    redirect_to current_character
  end
end
