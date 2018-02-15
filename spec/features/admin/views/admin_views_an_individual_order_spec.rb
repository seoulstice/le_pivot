require 'rails_helper'

feature "Admin can view individual order pages" do
  scenario "when I visit an valid order page" do
    stub_logged_in_user(create(:platform_admin))
    user = create(:user, first_name: "Gob", last_name: "Bluth")
    item_1 = create(:item, price: 11.00)
    item_2 = create(:item, price: 10.00)
    order = create(:order, total_price: 31.00, user: user)
    create(:order_item, item: item_1, order: order, quantity: 1)
    create(:order_item, item: item_2, order: order, quantity: 2)

    expected_total = "$31.00"

    visit order_path(order)

    expect(page).to have_content(todays_date)
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
