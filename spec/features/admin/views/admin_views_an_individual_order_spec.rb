require 'rails_helper'

feature "Admin can view individual order pages" do
  scenario "when I visit an valid order page" do
    user = create(:user, first_name: "Gob", last_name: "Bluth")
    admin = create(:admin)
    item_1 = create(:item, price: 11.00)
    item_2 = create(:item, price: 10.00)
    items_with_quantity_for_order = [ {item_1 => 1}, {item_2 => 2} ]
    order = create(:order_with_items, items_with_quantity: items_with_quantity_for_order)
    expected_total = "$31.00"

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit order_path(order)

    expect(page).to have_content(order.date)
    expect(page).to have_content("Gob Bluth")
    expect(page).to have_content(user.address)
    within("#item-#{item_1.id}") do
      within(".title") { expect(page).to have_link(item_1.title) }
      within(".quantity") { expect(page).to have_content(item_1.order_items.first.quantity) }
      within(".price") { expect(page).to have_content("$11.00") }
    end
    within("#item-#{item_2.id}") do
      within(".title") { expect(page).to have_link(item_2.title) }
      within(".quantity") { expect(page).to have_content(item_2.order_items.last.quantity) }
      within(".price") { expect(page).to have_content("$10.00") }
    end
    within(".order-total") do
      expect(page).to have_content(expected_total)
    end
  end
end

