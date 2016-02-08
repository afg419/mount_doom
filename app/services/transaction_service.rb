class TransactionService

  attr_accessor :character, :store
  attr_reader :sold, :bought

  def initialize(character, store)
    @character = character
    @store = store
  end

  def collect_items(trade_params)
    @sold = trade_param_to_item(trade_params["0"])
    @bought = trade_param_to_item(trade_params["1"])
  end

  def execute_transaction
    self.character.items -= sold
    self.character.items += bought
    self.character.save

    self.store.items -= bought
    self.store.items += sold
    self.store.save
  end

private

  def trade_param_to_item(trade_array)
    trade_array.map do |trade|
      Item.find(trade.split("-item-").last.split(" show")[0].to_i)
    end
  end
end
