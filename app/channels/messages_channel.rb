class MessagesChannel < ApplicationCable::Chanel

  def subscribe
    stream_from 'messages'
  end


end
