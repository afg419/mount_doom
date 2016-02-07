class CartItem < SimpleDelegator
  attr_reader :item, :quantity, :subtotal

  def initialize(item, quantity, subtotal)
    super(item)
    @quantity = quantity
    @subtotal = subtotal
  end
end
