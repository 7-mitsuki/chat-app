class UsersController < ApplicationController

  def edit
  end

  def update
    # 成功した場合はroot_pathへ
    if current_user.update(user_params)
      redirect_to root_path
    else
      # 元の記述を維持したまま、:editアクションのビューを表示
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
