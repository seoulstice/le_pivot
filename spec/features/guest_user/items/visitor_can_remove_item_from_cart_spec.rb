require 'rails_helper'

feature "Removing an item from my cart" do

  describe "When a visitor is viewing their cart" do
    scenario "they can remove an item" do
      item = create(:item)
      visit item_path(item)
      click_on "Add to cart"
      click_on "Add to cart"
      visit cart_path
      expect(page).to have_content(item.title)
      click_link("Remove")

      expect(current_path).to eq(cart_path)
      expect(page).to_not have_content(item.title)
      expect(page).to have_content("Successfully removed #{item.title} from your cart.")
      expect(page).to have_link(item.title, href: item_path(item))
    end
  end
end
