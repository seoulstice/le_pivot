require "rails_helper"

describe "When visiting create store form" do
  context "as a registered User" do
    it "a user can create a store" do
      user = create(:user)
      Seeder.add_roles
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit new_store_path
      fill_in "store[name]", with: "Vandelay Industries"
      click_on "Submit"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_link("My Stores")

      click_on "My Stores"
      expect(page).to have_content("Vandelay Industries")
      expect(page).to have_content("pending")
    end
  end
end
