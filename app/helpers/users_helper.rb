module UsersHelper
  # 渡されたユーザーでサインインする
  def user_sign_in(user)
    session[:user_id] = user.id
  end
  #サインアウトする。ログインしているユーザーのセッションを削除する。
  def user_sign_out
    session.delete(:user_id)
    @current_user = nil
  end

  #user signed_in>>true, doesn't sign_in>>false
  def user_signed_in?
    current_user.present?
  end

  #current_userのidがnilだった場合、セッションのidを付与する。
  def current_user
    if @current_user.nil?
      @current_user = User.find_by(id: session[:user_id])
    else
      @current_user
    end
  end

  #認証チェック。サインインしてなければサインインページにリダイレクトする。
  def authorize
    redirect_to sign_in_path unless user_signed_in?
  end

  #if user has signed in, redirect him/her to top page.
  def redirect_to_top_if_already_signed_in
    redirect_to list_path and return if user_signed_in?
  end

  #profileページのuser iconがなければダミーを使い、データがあればuploads/user/から使用する。
  def user_image_url(user)
    if user.image.present?
      image_tag user.image_url
    else
      image_tag "https://placehold.it/200x200/?text=no user's picture"
    end
  end

  #user signed in=> profile page, user not sign in =>sign in sign in page
  def redirect_user
    if user_signed_in?
      redirect_to users_profiles_path and return
    else
      redirect_to sign_in_path and return
    end
  end
end
