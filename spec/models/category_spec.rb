require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  context 'バリデーションのテスト' do
    example '有効なカテゴリーが登録できること' do
      expect(category).to be_valid
    end

    example 'カテゴリーが21文字以上の場合無効であること' do
      category = build(:category, category_name: "a" * 21)
      category.valid?
      expect(category.errors[:category_name]).to include('は20文字以内で入力してください')
    end

    example 'カテゴリー名が重複していれば無効であること' do
      other_category = build(:category, category_name: category.category_name)
      other_category.valid?
      expect(other_category.errors[:category_name]).to include('はすでに存在します')
    end
  end
end
