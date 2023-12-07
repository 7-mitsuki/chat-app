class RoomsController < ApplicationController

  def index
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def room_params
    # 配列に対して保存を許可したい場合は、キーをシンボル引数名として、空の配列値として記述する
    params.require(:room).permit(:name, user_ids: [])
  end

end
