require 'rails_helper'

feature "Admin approves a pending store" do
  context "A user has submitted a store for creation" do
    context "An admin can approve the pending store" do
      it "changes the status of the store from 'pending' to 'approved'" do
        admin = create(:platform_admin)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit admin_dashboard_path
        click_on 'Stores'

        expect(current_path).to eq(stores_path)

        within first(".store") do
          expect(page).to have_content(admin.stores.first.name)
          expect(page).to have_content("Status: pending")
          click_button "Activate"
        end

        expect(current_path).to eq(stores_path)

        within first(".store") do
          expect(page).to have_content(admin.stores.first.name)
          expect(page).to have_content("Status: active")
        end
      end
    end
  end
end
