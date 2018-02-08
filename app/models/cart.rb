class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def items
    contents.map { |id, quantity| CartItem.new(id, quantity)}
  end

  def total_price
    items.sum &:subtotal
  end

  def total_count
    contents.values.sum
  end

  def add_item(id)
    contents[id.to_s] = (contents[id.to_s] || 0) + 1
  end

  def decrease_quantity(id)
    if contents[id.to_s] > 0
      contents[id.to_s] -=1
    end
    if contents[id.to_s] == 0
      delete_item(id)
    end
  end

  def increase_quantity(id)
    contents[id.to_s] += 1
  end

  def count_of(id)
    contents[id.to_s].to_i
  end

  def cart_items
    contents.inject({}) do |result, (item_id, quantity)|
      result[Item.find(item_id)] = quantity
      result
    end
  end

  def delete_item(id)
    contents.delete(id.to_s)
  end

  def destroy
    @contents.clear
  end

end
