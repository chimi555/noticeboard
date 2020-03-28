require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }

  context 'バリデーションのテスト' do
    example '有効なトピックが登録できること' do
      expect(topic).to be_valid
    end

    example "ユーザーIDがなければ無効な状態であること" do
      topic = build(:topic, user_id: nil)
      topic.valid?
      expect(topic.errors[:user_id]).to include("を入力してください")
    end

    example 'タイトルがなければ無効であること' do
      topic = build(:topic, title: nil)
      topic.valid?
      expect(topic.errors[:title]).to include('を入力してください')
    end

    example 'タイトルが51文字以上の場合無効であること' do
      topic = build(:topic, title: "a" * 51)
      topic.valid?
      expect(topic.errors[:title]).to include('は50文字以内で入力してください')
    end

    example 'トピック概要が201文字以上の場合無効であること' do
      topic = build(:topic, description: "a" * 201)
      topic.valid?
      expect(topic.errors[:description]).to include('は200文字以内で入力してください')
    end
  end
end
