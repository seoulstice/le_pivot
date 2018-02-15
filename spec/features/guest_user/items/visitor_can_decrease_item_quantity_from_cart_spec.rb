require "rails_helper"

feature "Visitor cart has an item in it" do

  background do
    item = create(:item, price: 19.99, title: 'fancy pants', id: 1)
    visit item_path(item)
  end

  context "visitor sees that her cart has a quantity of 2" do
    describe "the visitor can remove the item" do
      it "visitor sees that she has 1 items in her cart and the subtotal of her order decreases" do

        2.times{ click_on "Add to cart" }

        visit cart_path
        expect(page).to have_content(39.98)
        expect(page).to have_link('fancy pants', item_path(Item.last))

        click_on "-"

        expect(page).to have_content('$19.99')
        expect(page).to have_link('fancy pants', item_path(Item.last))
      end
    end
  end

  context "a visitor has 1 item in their cart" do
    describe "they click on decrease quantity" do
      it "the user will not see anything in the cart" do

        click_on "Add to cart"

        visit cart_path

        expect(page).to have_link('fancy pants', item_path(Item.last))
        expect(page).to have_content('$19.99')

        click_on "-"

        expect(page).to have_content("Successfully removed")
      end
    end
  end

end
