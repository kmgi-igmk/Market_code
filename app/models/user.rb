# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)      not null
#  image           :string(255)
#  profile         :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  mount_uploader :image, UserImageUploader

  has_many :products, dependent: :destroy
  has_many :user_likes, dependent: :destroy

  #bcrypt
  has_secure_password

  #バリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  # sign_up_processの時のみpresenceをtrueにする。sign_in_processはpasswordのみtrueに。
  validates :password, presence: true, on: :sign_up_process, on: :sign_in_process
  validates :password_confirmation, presence: true, on: :sign_up_process
end
