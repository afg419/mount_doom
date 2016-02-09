class TransactionService

  attr_accessor :character, :store
  attr_reader :sold, :bought

  def initialize(character = nil, store = nil)
    @character = character || []
    @store = store || []
  end

  def collect_items(trade_params)
    @sold = trade_param_to_item(trade_params["0"])
    @bought = trade_param_to_item(trade_params["1"])
    {sold: sold, bought: bought}
  end

  def execute_transaction
    store.items += sold
    character.items += bought
    character.items -= sold
    store.items -= bought
  end

private

  def trade_param_to_item(trade_array)
    trade_array.to_a.map do |trade|
      Item.find(trade.split("-item-").last.split(" show")[0].to_i)
    end
  end
end
