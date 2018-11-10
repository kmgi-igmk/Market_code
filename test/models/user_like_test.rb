# == Schema Information
#
# Table name: user_likes
#
#  id         :bigint(8)        not null, primary key
#  product_id :bigint(8)
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UserLikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
