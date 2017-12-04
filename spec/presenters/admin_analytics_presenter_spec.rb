require 'rails_helper'

describe AdminAnalyticsPresenter do
  let(:analytics) { AdminAnalyticsPresenter.new }
  let!(:customer) { create(:user) }

  let(:customer_order_1) { create(:order, status: "completed", user: customer) }
  let(:customer_order_2) { create(:order, status: "completed", user: customer) }

  let(:store_item_1) { create(:item, title: "Book 1", price: 10.00) }
  let(:store_item_2) { create(:item, title: "Book 2", price: 20.00) }

  let(:add_order_item_1) { create(:order_item, item: store_item_1, quantity: 1, order: customer_order_1) }
  let(:add_order_item_2) { create(:order_item, item: store_item_2, quantity: 3, order: customer_order_2) }
  let(:add_item_to_customer_order) { customer_order_1.items << store_item_1 }

  before(:each) do
    add_item_to_customer_order
    add_order_item_1
    add_order_item_2
  end

  describe '#total_sales' do
    it 'returns the total sales from an order' do
      expect(analytics.total_sales).to eq 40.0
    end
  end

  describe '#average_quantity_purchased' do
    it 'returns the average quantity purchased for an order item' do
      expect(analytics.average_quantity_purchased).to eq 2
    end
  end

  describe '#completed_orders' do
    it 'returns the count of completed orders for an order' do
      expect(analytics.completed_orders).to eq 2
    end
  end

  describe '#sales_by_item_title' do
    it 'returns total sales by item title' do
      expect(analytics.sales_by_item_title).to eq({"Book 2"=>3, "Book 1"=>1})
    end
  end

  describe '#status_for_items' do
    it 'returns status for items by name' do
      expect(analytics.status_for_items).to eq({["Book 2", 3]=>1, ["Book 1", 3]=>2})
    end
  end

  describe '#orders_per_customer' do
    it 'returns user orders' do
      expect(analytics.orders_per_customer).to eq({"gob6@example.com"=>2})
    end
  end

  describe '#items_ordered_per_customer' do
    it 'returns quanity of items order by customer' do
      expect(analytics.items_ordered_per_customer).to eq({"gob7@example.com"=>4})
    end
  end
end
