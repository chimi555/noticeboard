class Category < ApplicationRecord
  # モデルの関連定義
  has_many :topic_categories, dependent: :destroy
  has_many :topics, through: :topic_categories
  # バリデーション
  validates :category_name, presence: true, uniqueness: true, length: { maximum: 20 }
end
