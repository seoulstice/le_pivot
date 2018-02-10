class CartItem < SimpleDelegator
  attr_reader :quantity, :subtotal

  def initialize(id, quantity)
    item_to_wrap = Item.find(id)
    super(item_to_wrap)
    @quantity = quantity
    @subtotal = quantity * price
  end
end
