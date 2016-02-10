class TransactionService

  attr_accessor :character, :store
  attr_reader :sold, :bought

  def initialize(character = nil, store = nil)
    @character = character || []
    @store = store || []
  end

  def collect_items(trade_params)
    @sold = trade_param_to_item(trade_params["0"])
    @bought = trade_param_to_item(trade_params["1"]).map do |item|
      duplicate_item(item)
    end
  end

  def execute_transaction
    character.items += bought
    character.items -= sold
    sold.each do |item|
      item.destroy
    end
  end

  def duplicate_item(item)
    Item.create(item.duplication_params)
  end

private

  def trade_param_to_item(trade_array)
    trade_array.to_a.map do |trade|
      Item.find(trade.split("-item-").last.split(" show")[0].to_i)
    end
  end
end
