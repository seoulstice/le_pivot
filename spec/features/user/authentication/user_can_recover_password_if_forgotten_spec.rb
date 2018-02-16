require 'rails_helper'

feature "Password Recovery" do
  context "As a user if I forget my password" do
    it "I can validate my account and create new password" do
      user = create(:user, email: "fake@fake.com", phone: "(504) 407-1457")
      visit "/login"

      click_link "forgot password?"
      expect(current_path).to eq('/password-reset')

      fill_in "reset_password[email]", with: user.email
      click_button "Confirm"

      expect(current_path).to eq(twilio_confirmation_path)
      expect(page).to have_content("Please enter the secret key we've just texted you:")

      last_message = TwilioServices.new(user).create_client.messages.list.first.body[-6..-1]
      fill_in "password_reset[key]", with: last_message
      click_button "Submit"

      expect(current_path).to eq('/new-password')
      expect(page).to have_content('Create your new password')

      fill_in "password_reset[new_password]", with: "password"
      click_button "Submit"

      expect(current_path).to eq(dashboard_path(user))
      expect(page).to have_content("Your password has been successfully updated!")
    end
  end
end
