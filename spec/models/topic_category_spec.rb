require 'rails_helper'

RSpec.describe TopicCategory, type: :model do
  let(:topic_category) { create(:topic_category) }

  context 'バリデーションのテスト' do
    example "有効なtopic_categoryレコードが登録できること" do
      expect(topic_category).to be_valid
    end

    example "topicIDがなければ無効な状態であること" do
      topic_category = build(:topic_category, topic_id: nil)
      expect(topic_category).not_to be_valid
    end

    example "categoryIDがなければ無効な状態であること" do
      topic_category = build(:topic_category, category_id: nil)
      expect(topic_category).not_to be_valid
    end
  end
end
