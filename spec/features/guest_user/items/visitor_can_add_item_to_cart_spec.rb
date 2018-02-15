require 'rails_helper'

RSpec.feature "Adding items to the cart" do
  let!(:item) { create(:item, title: "Black Cat Onesie", price: 10.00) }

  before(:each) do
    visit item_path(Item.last.id)
  end

  context "When a visitor adds items to their cart" do
    it "a message is displayed" do
      click_on "Add to cart"
      expect(page).to have_content("You now have 1 Black Cat Onesie")
    end

    it "the message correctly increments for multiple items" do
      click_on "Add to cart"
      expect(page).to have_content("You now have 1 Black Cat Onesie")
      click_on "Add to cart"
      expect(page).to have_content("You now have 2 Black Cat Onesies")
    end

    it "the total number of items in the cart increments" do
      expect(page).to have_content("Cart 0")
      click_on "Add to cart"
      expect(page).to have_content("Cart 1")
    end

    it "they can click cart and see all their checkout items" do
      click_on "Add to cart"
      click_on "Add to cart"
      click_on "Cart"

      expect(current_path).to eq(cart_path)
      expect(page).to have_css("img[src=\"#{item.image}\"]")
      expect(page).to have_content(item.title)
      expect(page).to have_content("2")

      within first('.total') do
        expect(page).to have_content "$20.00"
      end
    end
  end
end
