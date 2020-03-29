class Topic < ApplicationRecord
  # モデルの関連定義
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :topic_categories, dependent: :destroy
  has_many :categories, through: :topic_categories
  # バリデーション
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 200 }
end
