class OrderItemDecorator < ApplicationDecorator

  belongs_to :item

  delegate :price, :image, :title, to: :item

  formats_currency :subtotal

end
