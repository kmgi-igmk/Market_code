require 'test_helper'

class MarketsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get markets_list_url
    assert_response :success
  end

end
