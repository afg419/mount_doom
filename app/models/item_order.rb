class ItemOrder < ActiveRecord::Base
  belongs_to :item
  belongs_to :order

  def self.create_item_order(order, cart)
    cart.contents.each do |item_id, quantity|
      item_price = Item.find(item_id.to_i).price
      subtotal = item_price * quantity
      ItemOrder.create(order_id: order.id,
                       item_id: item_id, quantity: quantity, subtotal: subtotal)
    end
  end
end
