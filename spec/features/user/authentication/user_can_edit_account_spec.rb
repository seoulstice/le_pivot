require 'rails_helper'

describe "When a registered User" do
  context "navigates to account edit form" do
    it "the User can edit their account without entering a password" do
      user = create(:user, name: "Gob")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_user_path

      fill_in "user[name]", with: "George Oscar Bluth"
      click_on "Submit"

      expect(current_path).to eq(edit_user_path)
      expect(page).to have_content("George Oscar Bluth")
      expect(page).to have_content("Successfully updated your account information.")



    end
  end
end
