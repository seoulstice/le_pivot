class MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    message.user = current_user
    if !message.save
      redirect_to chatrooms_path
    else
      message.save
    end
  end

  private

   def message_params
     params.require(:message).permit(:content, :chatroom_id)
   end

end
