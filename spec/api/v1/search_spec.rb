require 'rails_helper'

describe "Search API" do

  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:type) { 'items' }
  let(:q) { 'diapers' }
  let(:results) do
    [
      {
        id: 1,
        title: "Nature's Diapers",
        description: "No chemicals or dyes. Also, they don't really work.",
        price: "$5.00"
      }, {
        id: 103,
        title: "Dopo Tesigns Shoulder Bag",
        description: "Versitile bag great for commuting. Even makes as an excellent diaper bag. #parentcore",
        price: "$5.00"
      }
    ]
  end
  before do
    not_diapers = 'not d i a p e r s'
    create(:item, id: 3, title: not_diapers, description: not_diapers)
    results.each do |hash|
      hash
      create(:item, **hash, price: 5)
    end
  end

  it 'searches items by title and description when valid API key is supplied' do
    get '/api/v1/search', params: {
      type: type,
      q: q,
      api_key: create(:api_key)
    }
    expected = {
      type: type,
      q: q,
      results: results
    }
    expect(response).to be_success
    expect(json).to eq(expected)
  end

  it 'includes case-insesitive matches' do
    get '/api/v1/search', params: {
      type: type,
      q: q.upcase,#  <----
      api_key: create(:api_key)
    }
    expected = {
      type: type,
      q: q,
      results: results
    }
    expect(response).to be_success
    expect(json).to eq(expected)
  end

  it 'responds with an error when missing API key' do
    get '/api/v1/search', params: {
      type: type,
      q: q
    }
    expected = { error: 'missing or invalid API key' }

    expect(response).to_not be_success
    expect(json).to eq(expected)
  end

  it 'responds with an error when API key is invalid' do
    get '/api/v1/search', params: {
      type: type,
      q: q,
      api_key: create(:api_key, user: nil)
    }
    expected = { error: 'missing or invalid API key' }

    expect(response).to be_unauthorized
    expect(json).to eq(expected)
  end
end
