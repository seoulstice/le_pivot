require 'rails_helper'

describe "Search API" do

  def search(search_params)
    get('/api/v1/search', params: search_params)
  end

  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:q) { 'diaper' }
  let(:type) { 'items' }
  let(:api_key) { create(:api_key) }
  let(:active_store) { |status| create(:store, status: :active) }
  let(:results) do
    [
      {
        id: 50,
        title: "Nature's Diapers",
        description: "No chemicals or dyes. Also, they don't really work.",
        price: "$5.00"
      }, {
        id: 103,
        title: "Dopo Tesigns Shoulder Bag",
        description: "Versitile bag great for commuting. Even makes as an excellent diaper bag. #parentcore #bringdownthebinary",
        price: "$5.00"
      }
    ]
  end
  before do
    not_diapers = 'not d i a p e r s'
    create(:item, title: not_diapers, description: not_diapers, store: active_store)
    results.each { |raw_item| create(:item, **raw_item, price: 5, store: active_store) }
  end

  it 'searches items by title and description when valid API key is supplied' do
    search(
      type: type,
      q: q,
      api_key: api_key
    )
    expected = {
      type: type,
      q: q,
      results: results
    }
    expect(response).to be_success
    expect(json).to eq(expected)
  end

  it 'includes case-insesitive matches' do
    search(
      type: type,
      q: q.upcase,#  <----
      api_key: api_key
    )
    expected = {
      type: type,
      q: q.upcase,#  <----
      results: results
    }
    expect(response).to be_success
    expect(json).to eq(expected)
  end

  it 'excludes retired items' do
    create(:item, condition: :retired)
    search(
      type: type,
      q: q,
      api_key: api_key
    )
    expected = {
      type: type,
      q: q,
      results: results
    }
    expect(response).to be_success
    expect(json).to eq(expected)
  end

  it 'excludes items from non-active stores' do
    %i{ pending suspended }.each do |status|
      create(:item, store: create(:store, status: status))
    end
    search(
      type: type,
      q: q,
      api_key: api_key
    )
    expected = {
      type: type,
      q: q,
      results: results
    }
    expect(response).to be_success
    expect(json).to eq(expected)
  end

  it 'responds with an error when missing API key' do
    search(
      type: type,
      q: q
    )
    expected = { error: 'missing or invalid API key' }

    expect(response).to be_unauthorized
    expect(json).to eq(expected)
  end

  it 'responds with an error when API key is invalid' do
    search(
      type: type,
      q: q,
      api_key: create(:api_key, user: nil)
    )
    expected = { error: 'missing or invalid API key' }

    expect(response).to be_unauthorized
    expect(json).to eq(expected)
  end

end
