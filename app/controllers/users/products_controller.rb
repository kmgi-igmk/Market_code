class Users::ProductsController < ApplicationController
  #新規出品ページ
  def new
    if current_user.nil?
      redirect_to sign_in_path
    else
      @product = Product.new
    end
  end

  #新規出品する
  def create
    @product = current_user.products.build(product_params)
      if @product.save
        redirect_to users_products_path, flash: { notice: "出品しました！"}
      else
        flash[:danger] = "出品できませんでした"
        render "new" and return
      end
  end

  #ユーザーのproducts
  def index
    # Product modelからuserがcurrent_userであるものを取得する。
    # findはid以外での検索はRails4で廃止された。
    @products = Product.where(user: current_user)
  end

  #userのproduct詳細
  #現在ログインしているUserの指定されたProductの詳細を表示する。
  def show
    @product = current_user.products.find(params[:id])
    #販売手数料(margin)と販売利益(profit)を計算し、切り捨てで表示する。
    @margin = (@product.price * 0.1).floor
    @profit = @product.price - @margin
  end

  #userのproduct編集画面
  def edit
    @product = current_user.products.find(params[:id])
  end

  #userのproduct編集プロセス。
  def update
    @product = current_user.products.find(params[:id])

    @product.update(product_params)
    redirect_to users_product_path(@product) and return
  end

  #userのproduct削除
  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:success] = "商品を削除しました。"
      redirect_to users_products_path and return
    else
      flash[:danger] = "削除できませんでした。"
      render "index" and return
    end
  end

  private
  def product_params
    params.require(:product).permit(:id, :name, :description, :price, :category_id, :image1, :image2, :image3, :status)
  end
end
