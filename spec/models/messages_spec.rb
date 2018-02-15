require 'rails_helper'

  RSpec.describe Message do
    describe 'relationships' do
      it "will be invalid if not associatd with a chatroom " do
        user = create(:user)
        message = Message.new(user: user)
        expect(message).to_not be_valid
      end

      it "will be invalid if not associatd with a user " do
        user = create(:user)
        chatroom = Chatroom.create
        message = Message.new(chatroom: chatroom)
        expect(message).to_not be_valid
      end

      it "will be valid if associatd with a chatroom " do
        user = create(:user)
        chatroom = Chatroom.new
        message = Message.new(user: user, chatroom: chatroom)
        expect(message).to be_valid
      end
    end
  end
