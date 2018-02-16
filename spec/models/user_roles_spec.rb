require 'rails_helper'

describe UserRole do
  context 'relationships' do
    it "has a relationship with store" do
      ur = UserRole.new
      expect(ur).to respond_to(:store)
    end

    it "has a relationship with users" do
      ur = UserRole.new
      expect(ur).to respond_to(:user)
    end

    it "has a relationship with roles" do
      ur = UserRole.new
      expect(ur).to respond_to(:role)
    end
  end
end
