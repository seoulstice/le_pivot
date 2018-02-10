require 'rails_helper'

describe 'When a user visits an active store' do
  it 'the user can see all active and inactive items in store' do
    user = create(:user)
    store = create(:store, name: "Vandelay Industries")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    active_item1, active_item2 = create_list(:item, 2, store_id: store.id, condition: 0)
    inactive_item = create(:item, store_id: store.id, condition: 1)
    unassociated_item = create(:item, condition: 0)

    visit store_path(store)

    expect(page).to have_content(active_item1.title)
    expect(page).to have_content(active_item2.title)
    expect(page).to_not have_content(inactive_item.title)
  end
end
