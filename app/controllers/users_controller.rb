class UsersController < ApplicationController
  before_action :authorize, except: [:sign_up, :sign_up_process, :sign_in, :sign_in_process]
  before_action :redirect_to_top_if_already_signed_in, only: [:sign_up, :sign_in]

  #新規登録
  def sign_up
    @user = User.new
  end

  #登録処理
  def sign_up_process
    @user = User.new(user_params)
    if @user.save
      # セッション処理.登録が完了したらサインインしてトップページへ
      user_sign_in(@user)
      redirect_to users_profiles_path, flash: { notice: "登録が完了しました" }
    else
      #登録失敗
      render "sign_up" and return
    end
  end

  #ログイン
  def sign_in
    @user = User.new
  end

  #ログイン処理
  def sign_in_process
    @user = User.new
    #メールアドレスでユーザーを検索
    user = User.find_by(email: user_params[:email])
    #パスワードの一致を検証
    if user && user.authenticate(user_params[:password])
      user_sign_in(user)
      redirect_to users_profiles_path, flash: { notice: "ログインに成功しました" }
    else
      flash[:danger] = "ログインに失敗しました"
      render "sign_in" and return
    end
  end

  #サインアウト
  def sign_out
    #セッションを破棄
    user_sign_out
    #サインインページへ遷移
    redirect_to sign_in_path and return
  end

  #商品をお気に入りにする
  def create
    @product = Product.find(params[:id])
    #その商品をお気に入りにしていたら解除、していなかったらCreateする。
    if UserLike.exists?(product_id: @product.id, user_id: current_user.id)
      UserLike.find_by(product_id: @product.id, user_id: current_user.id).destroy
    else
      UserLike.create(product_id: @product.id, user_id: current_user.id)
    end
    redirect_to markets_index_path and return
  end

  #お気に入り商品を表示
  def show
    #UserLikeモデルからuser_idでcurrent_userのUserLikeモデルを配列で受け取る。
    @user_likes = UserLike.where(user_id: current_user.id)
    #eachの中で追加するために、@productsを空の配列として宣言。
    @products = []
    #69行目で取得した配列からUserLikeモデルを1つずつeachで処理する。
    @user_likes.each do |user_like|
      #取得した1件のUserLikeモデルからproductを取り出して、@products配列に追加する。
      @products << user_like.product
    end
  end

  private
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :image)
  end
end
