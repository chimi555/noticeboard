class Topic < ApplicationRecord
  # モデルの関連定義
  belongs_to :user
  # バリデーション
  validates :user_id, presence: true
end
