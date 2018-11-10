# == Schema Information
#
# Table name: products
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)
#  category_id :bigint(8)
#  name        :string(255)
#  description :text(65535)
#  price       :integer
#  image1      :string(255)
#  image2      :string(255)
#  image3      :string(255)
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
