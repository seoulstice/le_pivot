require 'rails_helper'

feature 'Store Show Page' do
  scenario 'shows all active items in store with links to details' do

    stub_logged_in_user
    store = create(:store, name: "Vandelay Industries")
    active_item1, active_item2 = create_list(:item, 2, store: store, condition: :active)
    inactive_item = create(:item, store_id: store.id, condition: :retired)
    unassociated_item = create(:item, condition: :active)
    visit store_path(store)

    expect(page).to have_content(active_item1.title)
    expect(page).to have_content(active_item2.title)
    expect(page).to have_link(active_item1.title, href: item_path(active_item1))
    expect(page).to_not have_content(inactive_item.title)
    expect(page).to_not have_content(unassociated_item.title)

  end
end
