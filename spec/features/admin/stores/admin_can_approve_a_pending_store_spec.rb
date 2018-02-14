require 'rails_helper'

feature "Admin approves a pending store" do
  context "A user has submitted a store for creation" do
    context "An admin can approve the pending store" do
      it "changes the status of the store from 'pending' to 'approved'" do

        stub_logged_in_user(create(:platform_admin))
        store = create(:store)
        visit stores_path
        click_on 'Stores'

        within first(".store") do
          expect(page).to have_content(store.name)
          expect(page).to have_content("Status: pending")
          click_button "Activate"
          expect(page).to have_content(store.name)
          expect(page).to have_content("Status: active")
        end

      end
    end
  end
end
