require 'rails_helper'

describe AdminAnalyticsPresenter do

  let(:analytics){ AdminAnalyticsPresenter.new }

  it '#total_sales returns the total price for completed orders' do
    create_list(:order, 2, total_price: 2, status: :completed)
    create(     :order,    total_price: 1, status: :cancelled)
    expect(analytics.total_sales).to eq 4
  end

  it '#average_quantity_purchased' do
    create(:order_item, quantity: 1)
    create(:order_item, quantity: 5)
    expect(analytics.average_quantity_purchased).to eq 3
  end

  it '#completed_orders returns the count' do
    create_list(:order, 2, status: :completed)
    create(     :order,    status: :cancelled)
    expect(analytics.completed_orders).to eq 2
  end

  it '#sales_by_item_title' do
    create(:item, title: '2 x 3') do |item|
      create_list(:order_item, 2, quantity: 3, item: item) end
    create(:item, title: '3 x 4') do |item|
      create_list(:order_item, 3, quantity: 4, item: item) end

    expect(analytics.sales_by_item_title).to eq( "2 x 3" => 6, "3 x 4" => 12 )
  end

  it '#orders_per_customer' do
    create(:user, email: 'two') { |user| create_list(:order, 2, user: user) }
    create(:user, email: 'three') { |user| create_list(:order, 3, user: user) }
    expect(analytics.orders_per_customer).to eq( 'two' => 2, 'three' => 3 )
  end

  it '#items_ordered_per_customer' do
    create(:user, email: 'one') do |user|
      create_list(:order, 1, user: user) do |order|
        create_list(:order_item, 1, quantity: 1, order: order)
      end
    end
    create(:user, email: 'two four') do |user|
      create_list(:order, 2, user: user) do |order|
        create_list(:order_item, 3, quantity: 4, order: order)
      end
    end
    expect(analytics.items_ordered_per_customer).to eq( 'two four' => 24, 'one' => 1 )
  end
end
