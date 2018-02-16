require 'rails_helper'

describe TwilioServices do
  before(:each) do
    user = create(:user, phone: "(504) 407-1457")
    @twilio = TwilioServices.new(user)
  end
  describe 'preparations' do
    describe 'generate code' do
      it "can generate a random 6 letter code" do
        code_1 = @twilio.generate_code
        code_2 = @twilio.generate_code

        expect(code_1.length).to eq(6)
        expect(code_2.length).to eq(6)
        expect(code_2).to_not eq(code_1)
      end

      it "can format a phone number for api consumption" do
        phone = @twilio.format_phone

        expect(phone).to eq("5044071457")
      end
    end
  end

  describe "send text messges via" do
    it "can send a message to a user" do
      
    end
  end
end
