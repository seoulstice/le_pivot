require 'rails_helper'

RSpec.describe Store do
  context "relationship validaitons" do
    it "has many items" do
      store = build(:store)
      expect(store).to respond_to(:items)
    end
    it "has many user_roles" do
      store = build(:store)
      expect(store).to respond_to(:user_roles)
    end
    it "has one twitter_account" do
      store = build(:store)
      expect(store).to respond_to(:twitter_account)
    end
  end
  context "validatiosn" do
    it "will not be valid if theres no name" do
      store = Store.new
      expect(store).to_not be_valid
    end
    it "will be valid with name" do
      store = Store.new(name: "HALLLLLLO")
      expect(store).to be_valid
    end
  end
  context "model tests" do
    scenario "active items returns all active items associate dwith store" do
      store = Store.create(name: "top gun")
      items = create_list(:item, 5, condition: "active", store: store)
      items_2 = create_list(:item, 6, condition: "retired", store: store)
      expect(store.active_items.count).to eq(5)
    end
  end
end
