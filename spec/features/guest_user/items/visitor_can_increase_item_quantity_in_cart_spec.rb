require 'rails_helper'

feature "Visitor can increase an item's quantity in the cart" do
  let!(:item) { create(:item, price: 19.99) }

  scenario "visitor has an item in the cart and then she increases it to 2" do
    visit items_path

    click_on "Add to cart"

    visit cart_path
    expect(page).to have_content(item.title)
    expect(page).to have_content(1)

    click_on "+"

    expect(current_path).to eq('/cart')
    expect(page).to have_content(item.title)

    expect(page).to have_content(2)
    expect(page).to have_content("$39.98")
  end
end
