class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def total_price
    @total_price ||= order_items.sum(&:subtotal).round(2)
  end

  def order_items
    @order_items ||= contents.map do |id, quantity|
      OrderItem.new({ item_id: id, quantity: quantity })
    end
  end

  def increase_quantity(id)
    adjust(id, 1)
  end

  def decrease_quantity(id)
    adjust(id, -1)
  end

  def count_of(id)
    get(id)
  end

  def delete_item(id)
    set(id, 0)
  end

  def destroy
    contents.clear
  end

  private

    def get(id)
      contents[id.to_s] || 0
    end

    def set(id, new_value)
      id = id.to_s
      contents[id] = new_value
      contents.delete(id) if contents[id] < 1
    end

    def adjust(id, delta)
      new_value = get(id) + delta
      set(id, new_value)
    end

end
