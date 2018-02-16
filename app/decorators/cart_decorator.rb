class CartDecorator < ApplicationDecorator

  has_many :order_items

  def total_count
    contents.values.sum
  end

  def link_to_show
    link_to 'Cart', cart_path, class: "btn"
  end

  def link_to_checkout

  end

end
