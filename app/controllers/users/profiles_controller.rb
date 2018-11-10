class Users::ProfilesController < ApplicationController
  #プロフィールページトップ
  def show
    if current_user.nil?
      redirect_to sign_in_path
    else
      @user = User.find(current_user.id)
    end
  end

  #プロフィール編集
  def edit
    @user = User.find(current_user.id)
  end

  #プロフィール更新処理
  def update
    current_user.update(user_params)
    redirect_to users_profiles_path and return
  end

  private
  def user_params
    params.require(:user).permit(:id, :name, :email, :profile, :image)
  end
end
