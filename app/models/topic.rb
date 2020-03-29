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

  # カテゴリー更新処理
  def save_categories(categories)
    current_categories = self.categories.pluck(:category_name) unless self.categories.nil?
    old_categories = current_categories - categories
    new_categories = categories - current_categories

    old_categories.each do |old_name|
      self.categories.delete Category.find_by(category_name: old_name)
    end

    new_categories.each do |new_name|
      topic_category = Category.find_or_create_by(category_name: new_name)
      self.categories << topic_category
    end
  end
end
