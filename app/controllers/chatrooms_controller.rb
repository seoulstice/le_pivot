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
      @chatroom.update(slug: params[:topic].parameterize)
      redirect_to support_path(@chatroom.slug)
    else
      render :new
    end
  end

  private

    def chatroom_params
      params.permit(:chatroom).require(:topic
    end

end
