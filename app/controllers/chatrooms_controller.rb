class ChatroomsController < ApplicationController

  def index
    @chatrooms = Chatroom.all
  end

  def show
    @chatroom = Chatroom.find_by_slug!(params[:slug])
    @message  = Message.new
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    chatroom = Chatroom.create(chatroom_params)
    try_save(chatroom, chatroom_path(chatroom.slug), new_chatroom_path,
      "Welcome to the #{chatroom.topic} room.")
  end

  def destroy
    Chatroom.destroy_all
    redirect_to chatrooms_path
  end

  private

    def chatroom_params
      params.require(:chatroom).permit(:topic)
    end

end
