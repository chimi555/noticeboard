require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }

  context 'バリデーションのテスト' do
    example "有効なコメントが登録できること" do
      expect(comment).to be_valid
    end

    example "ユーザーIDがなければ無効な状態であること" do
      comment = build(:comment, user_id: nil)
      comment.valid?
      expect(comment.errors[:user_id]).to include("を入力してください")
    end

    example "トピックIDがなければ無効な状態であること" do
      comment = build(:comment, topic_id: nil)
      comment.valid?
      expect(comment.errors[:topic_id]).to include("を入力してください")
    end
  end
end
