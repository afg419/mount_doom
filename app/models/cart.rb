class Cart
  attr_reader :contents

  def initialize(raw_data)
    @contents = raw_data || {}
  end

  def cart_items
    @contents.map do |item_id, quantity|
      item = Item.find(item_id)
      subtotal = quantity * item.price
      CartItem.new(item, quantity, subtotal)
    end
  end

  def total
    cart_items.reduce(0) { |sum, n| sum + n.subtotal }
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def subtract_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] -= 1
    if contents[item_id.to_s] == 0
      contents.delete(item_id.to_s)
    end
    Item.find(item_id)
  end

  def cart_size
    @contents.values.sum
  end

  def count_of(item_id)
    contents[item_id.to_s]
  end

  def clear
    @contents = {}
  end

  def add_or_subtract_item(action, item)
    if action == "add"
      add_item(item.id)
    else
      subtract_item(item.id)
    end
  end

  def remove_item_completely(item_id)
    contents.delete(item_id.to_s)
  end

  def remove_notice?(action)
    action == "subtract"
  end

end
