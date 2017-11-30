require "rails_helper"

RSpec.describe "As a visitor" do
  describe "when I visit my cart" do
    it "I can sign up or log in" do
      create(:item, title: "Banana Stand")
      visit items_path
      click_on "Add to cart"
      visit '/carts'
      expect(page).to have_content("Create new account")
      expect(page).to have_content("Login")
      click_on "Create new account"
      fill_in "user[first_name]", with: "Tester"
      fill_in "user[last_name]", with: "McTesty"
      fill_in "user[email]", with: "testerson@testmail.com"
      fill_in "user[password]", with: "testing"
      click_on "Submit"
      visit '/carts'

      expect(page).to have_content("Banana Stand")
      expect(page).to have_content("1")
    end
  end
end
