module MarketsHelper
  #URL直打ち禁止
  def block_direct_link
    redirect_to markets_index_path if request.referrer == nil
  end
end
