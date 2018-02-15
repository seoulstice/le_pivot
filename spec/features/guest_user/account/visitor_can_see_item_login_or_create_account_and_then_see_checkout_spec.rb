require "rails_helper"

RSpec.describe "As a visitor" do
  describe "when I visit my cart" do
    it "I can sign up or log in" do
      create(:item, title: "Banana Stand")
      visit item_path(Item.last.id)
      click_on "Add to cart"
      visit cart_path
      expect(page).to have_content("create an account")
      expect(page).to have_content("login")
      click_on ("create an account")
      fill_in "user[first_name]", with: "Tester"
      fill_in "user[last_name]", with: "McTesty"
      fill_in "user[email]", with: "testerson@testmail.com"
      fill_in "user[password]", with: "testing"
      click_on "Submit"
      visit cart_path

      expect(page).to have_content("Banana Stand")
      expect(page).to have_content("1")
    end
  end
end
