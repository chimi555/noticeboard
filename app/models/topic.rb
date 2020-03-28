class Topic < ApplicationRecord
  # モデルの関連定義
  belongs_to :user
  # バリデーション
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 200 }
end
