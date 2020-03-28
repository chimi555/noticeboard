class User < ApplicationRecord
  # モデルの関連定義
  has_many :topics, dependent: :destroy
  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # バリデーション
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, uniqueness: true, presence: true
end
