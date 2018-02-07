require "rails_helper"

describe "Visitor cart has an item in it" do
  context "visitor sees that her cart has a quantity of 2" do
    describe "the visitor can remove the item" do
      it "visitor sees that she has 1 items in her cart and the subtotal of her order decreases" do
        item = create(:item, price: 19.99)
        visit items_path

        click_on "Add to cart"
        click_on "Add to cart"

        visit cart_path
        expect(page).to have_content(2)
        expect(page).to have_content(39.98)
        expect(page).to have_content(item.title)

        click_on "-"

        expect(page).to have_content(19.99)
        expect(page).to have_content(item.title)
        expect(page).to have_content("$19.99")
      end
    end
  end

  context "a visitor has 1 item in their cart" do
    describe "they click on decrease quantity" do
      it "the user will not see anything in the cart" do
        item = create(:item, price: 19.99)
        visit items_path

        click_on "Add to cart"

        visit cart_path

        expect(page).to have_content(1)
        expect(page).to have_content(item.title)
        expect(page).to have_content("$19.99")

        click_on "-"

        expect(page).to have_content("Successfully removed")
      end
    end
  end

end
