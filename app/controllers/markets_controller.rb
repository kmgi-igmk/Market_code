class MarketsController < ApplicationController
  before_action :authorize, except: [:index]
  before_action :block_direct_link, except: [:index]
  #商品一覧ページ
  def index
    @products = Product.all

    #@productsを条件によって絞り込み。
    @products = @products.where("name like ? or description like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%") if params[:keyword].present?
    @products = @products.where("category like ?", "%#{params[:category_id]}%") if params[:category_id].present?
    @products = @products.where(price: params[:mini_price].to_i..Float::INFINITY) if params[:mini_price].present?
    @products = @products.where(price: -Float::INFINITY..params[:max_price].to_i) if params[:max_price].present?
    @products = @products.where("name like ? or description like ?", "%#{params[:word]}%", "%#{params[:word]}%").order("id desc") if params[:word].present?

    #並び替えの条件があれば並び替える。
    if params[:order].present? && params[:order][:status].present?
      if params[:order][:status] == "price_order_ascend"
        @products = @products.order("price asc")
      elsif params[:order][:status] == "price_order_descend"
        @products = @products.order("price desc")
      elsif params[:order][:status] == "created_at_descend"
        @products = @products.order("created_at desc")
      elsif params[:order][:status] == "created_at_ascend"
        @products = @products.order("created_at asc")
      end
    else
      @products = @products.order("id desc")
    end

    #選択されたSelectによってstatus別に商品を表示する。
    if params[:sort].present? && params[:sort][:status].present?
      if params[:sort][:status] == "selling"
        @products = @products.where(status: 0)
      elsif params[:sort][:status] == "soldout"
        @products = @products.where(status: 1)
      end
    else
      @products = @products.order("id desc")
    end
    #8個ずつの表示にする。
    @products = @products.page(params[:page]).per(8)
  end

  #商品詳細ページ
  def show
    @product = Product.find(params[:id])

  end
  #商品購入ページ
  def payment
    @product = Product.find(params[:id])
  end

  #商品購入プロセス
  def payment_process
    @product = Product.find(params[:id])
    #商品のステータスを売切にする
    @product.soldout!
    flash[:success] = "商品を購入しました。"
    redirect_to markets_index_path and return
  end
end
