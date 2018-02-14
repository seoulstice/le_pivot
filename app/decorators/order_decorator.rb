class OrderDecorator < ApplicationDecorator

  has_one :user
  has_many :order_items

  formats_datetime :created_at
  formats_currency :total_price

### LINKS ###

  def button_to_cancel
    return unless ordered? || paid?
    button_to(
      "Cancel",
      order_path(self, status: "cancelled"),
      method: :patch,
      class: badge(:warning)
    )
  end

  def button_to_mark_as_paid
    return unless ordered?
    button_to(
      "Mark as Paid",
      order_path(order, status: "paid"),
      method: :patch,
      class: badge(:success)
    )
  end

  def button_to_mark_as_complted
    return unless paid?
    button_to(
      "Mark as Completed",
      order_path(order, status: "completed"),
      method: :patch,
      class: badge(:success)
    )
  end

end
