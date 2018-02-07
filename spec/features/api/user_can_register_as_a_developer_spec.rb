require 'rails_helper'

feature 'Developer Registration' do

  scenario %{
    As a visitor
    When I visit "/settings/developer"
    Then I should be redirected to "/login"
  } do
    visit '/settings/developer'
    expect(page).to have_current_path('/login')
  end

  scenario %{
    As a logged in user
    When I visit "/Dashboard"
    And I click "Developer" (should be in the footer)
    And I click "Register"
    Then I should see an API key
    And my current path should still be "/settings/developer"
  } do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(create(:user))
    visit('/dashboard')
    within('.footer') { click_on 'Developer' }
    click_on 'Register'

    expect(page).to have_current_path('/settings/developer')
    expect(page).to have_content(/API key: [\w\d\-]{22}/)
  end

  scenario %{
    As a developer
    When I visit "/settings/developer"
    Then I should see my API Key
    And when I click "Reset API Key"
    Then I should see a new API key replace the old one
    And my current path should be still be "/settings/developer"
  } do
    developer = create(:developer, api_key: "a_22_character_api_key")
    stub_logged_in_user(developer.user)
    visit '/settings/developer'

    expect(page).to have_content("a_22_character_api_key")
    click_on 'Reset API Key'
    expect(page).to have_content(/API key: [\w\d\-]{22}/)
  end

end
