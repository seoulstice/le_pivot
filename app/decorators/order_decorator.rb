class OrderDecorator < ApplicationDecorator

  has_one :user
  has_many :order_items

  formats_datetime :created_at
  formats_currency :total_price

### LINKS ###



  def button_to_cancel
    return unless ordered? || paid?
    link_to(
      "Cancel",
      admin_order_path(self, status: "cancelled"),
      method: :patch,
      class: "badge badge-warning"
    )
  end

  def button_to_mark_as_paid
    return unless ordered?
    link_to(
      "Mark as Paid",
      admin_order_path(self, status: "paid"),
      method: :patch,
      class: "badge badge-success"
    )
  end

  def button_to_mark_as_completed
    return unless paid?
    link_to(
      "Mark as Completed",
      admin_order_path(self, status: "completed"),
      method: :patch,
      class: "badge badge-success"
    )
  end

end
