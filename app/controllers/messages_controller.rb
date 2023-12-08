class MessagesController < ApplicationController
  def index
    # routes で確認すると、:room_idとなっているので、paramsから取得できる
    @room = Room.find(params[:room_id])
    @message = Message.new()
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect room_messages_path(@room)
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end

end
