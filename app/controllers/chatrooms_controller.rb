class ChatroomsController < ApplicationController

  def index
    @chatrooms = Chatroom.all
  end

  def show
    @chatroom = Chatroom.find_by(slug: params[:slug])
    @message  = Message.new
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to chatroom_path(slug: @chatroom.slug)
    else
      render :new
    end
  end

  def destroy
    @chatroom = Chatroom.find_by(slug: params[:slug])
    @chatroom.destroy

    redirect_to chatrooms_path
  end

  private

    def chatroom_params
      params.require(:chatroom).permit(:topic)
    end

end
