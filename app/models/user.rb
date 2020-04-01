class User < ApplicationRecord
  # モデルの関連定義
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # バリデーション
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, uniqueness: true, presence: true
  # role定義
  enum role: { normal: 0, admin: 1, test: 2 }
end
