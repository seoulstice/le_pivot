require 'rails_helper'

RSpec.describe Order do
  describe 'validations' do
    describe 'invalid attributes' do
      it 'is invalid without a status' do
        order = build(:order, status: nil)
        expect(order).to be_invalid
      end

    end
    describe 'valid attributes' do
      it 'is valid' do
        order = build(:order)
        expect(order).to be_valid
      end
    end
  end
  describe 'realtionships' do
    it 'belongs to a user' do
      order = build(:order)
      expect(order).to respond_to(:user)
    end

    it 'has many items' do
      item = create(:item)
      order = build(:order, items: [item])
      expect(order).to respond_to(:items)
      expect(order.items.first).to be_an(Item)
    end

    it 'has many order items' do
      item = create(:item)
      order = build(:order)
      oi = create(:order_item,order: order, item: item)

      expect(order).to respond_to(:order_items)
    end
  end

  describe "instance methods" do
    it "can return total price of items" do
      order = create(:order, total_price: 21.0)
      item_1 = create(:item, price: 10.00)
      item_2 = create(:item, price: 1.00)
      item_not_included = create(:item, title: "Banana Stand", price: 100.00)
      create(:order_item, order: order, item: item_1, quantity: 2)
      create(:order_item, order: order, item: item_2, quantity: 1)
      expect(order.total_price).to eq(21.0)
    end

    it "can return the order date" do
      order = create(:order, created_at: "2017-09-13 01:13:04 -0600")

      expect(order.created_at).to eq("2017-09-13 01:13:04 -0600")
    end
  end

  describe "class methods" do
    it "can count by status" do
      create(:order, status: "ordered")
      create(:order, status: "ordered")
      create(:order, status: "paid")
      create(:order, status: "cancelled")

      status_count = {"paid"=>1, "ordered"=>2, "cancelled"=>1}

      expect(Order.count_by_status).to eq(status_count)
    end

    it "can filter by status" do
      ordered   = create(:order, status: "ordered")
      paid_1    = create(:order, status: "paid")
      paid_2    = create(:order, status: "paid")
      cancelled = create(:order, status: "cancelled")

      all_ordered   = Order.filter_by_status("ordered")
      all_paid      = Order.filter_by_status("paid")
      all_cancelled = Order.filter_by_status("cancelled")

      expect(all_ordered).to include(ordered)
      expect(all_ordered.count).to eq(1)

      expect(all_paid).to include(paid_1)
      expect(all_paid).to include(paid_2)
      expect(all_paid.count).to eq(2)

      expect(all_cancelled).to include(cancelled)
      expect(all_cancelled.count).to eq(1)
    end

    it "can count of completed orders" do
      ordered   = create(:order, status: "ordered")
      completed_1    = create(:order, status: "completed")
      completed_2    = create(:order, status: "completed")
      cancelled = create(:order, status: "cancelled")

      expect(Order.count_of_completed_orders).to eq(2)
    end

    it "can calculate total gross price" do
      ordered   = create(:order, status: "ordered")
      completed_1    = create(:order, status: "completed",total_price: 2.00)
      completed_2    = create(:order, status: "completed", total_price: 2.00)
      cancelled = create(:order, status: "cancelled")

      expect(Order.shop_total_gross).to eq(4.00)
    end
  end
end
