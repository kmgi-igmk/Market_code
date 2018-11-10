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

class Product < ApplicationRecord
  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader

  belongs_to :user
  belongs_to :category
  has_many :user_likes, dependent: :destroy

  enum status:{selling: 0, soldout: 1}
  #selling =>出品中、soldout =>売切

  #バリデーション
  #商品名、説明文、カテゴリ、価格は必須選択項目とする
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :price, presence: true

  #商品を、ログインしているユーザーがお気に入りにしているかどうかを判定
  #データに基づいているためModelに記述。
  def favorite?(user)
    self.user_likes.exists?(user_id: user.id)
  end
end
