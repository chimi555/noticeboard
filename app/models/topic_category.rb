class TopicCategory < ApplicationRecord
  # モデルの関連定義
  belongs_to :topic
  belongs_to :category
  # バリデーション
  validates :topic_id, presence: true
  validates :category_id, presence: true
end
