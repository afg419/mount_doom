class TransactionService

  attr_accessor :character, :store, :total
  attr_reader :sold, :bought

  def initialize(character = nil, store = nil, total = 0)
    @character = character || []
    @store = store || []
    @total = total.to_i
  end

  def saves_money
    @character.money = @character.money + @total
    @character.save
  end

  def collect_items(trade_params)
    @sold = trade_param_to_item(trade_params["0"]) + trade_param_to_incident(trade_params["0"])
    saves_money
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

  def break_apart_items_from_array(trade_array)
    trade_array.to_a.select do |trade|
      trade.split[3].starts_with?("player") || trade.split[3].starts_with?("store")
    end
  end

  def break_apart_incidents_from_array(trade_array)
    trade_array.to_a.select do |trade|
      trade.split[3].starts_with?("incident")
    end
  end

  def trade_param_to_incident(trade_array)
    break_apart_incidents_from_array(trade_array).map do |trade|
      Incident.find(trade.split("-item-").last.split(" show")[0].to_i)
    end
  end

  def trade_param_to_item(trade_array)
    break_apart_items_from_array(trade_array).map do |trade|
      Item.find(trade.split("-item-").last.split(" show")[0].to_i)
    end
  end
end
