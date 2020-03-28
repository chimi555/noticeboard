class Comment < ApplicationRecord
  # モデルの関連定義
  belongs_to :user
  belongs_to :topic
  # バリデーション
  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :topic_id, presence: true
end
