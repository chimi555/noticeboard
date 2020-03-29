require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:topic) { create(:topic, user: user) }

  describe '#create' do
    context 'ログイン済ユーザー' do
      before do
        sign_in other_user
      end

      example '新しいコメントが登録できること' do
        expect do
          post topic_comments_path(topic.id), params: { comment: { content: 'テストコメントです。' } }
        end.to change(topic.comments, :count).by(1)
      end
    end

    context 'ログインしていないユーザー' do
      example '新しいコメントが登録できないこと' do
        expect do
          post topic_comments_path(topic.id), params: { comment: { content: 'テストコメントです。'} }
        end.not_to change(topic.comments, :count)
      end
    end
  end

  describe '#destroy' do
    let!(:comment) { create(:comment, user: user, topic: topic) }

    context 'ログイン済ユーザー' do
      context 'コメント所有者の場合' do
        before do
          sign_in user
        end

        example 'コメントを削除できる' do
          expect do
            delete topic_comment_path(comment.topic_id, comment.id)
          end.to change(topic.comments, :count).by(-1)
          expect(response).to redirect_to topic_path(topic)
        end
      end

      context 'コメント所有者でない場合' do
        before do
          sign_in other_user
        end

        example 'homeページにリダイレクトされる' do
          expect do
            delete topic_comment_path(comment.topic_id, comment.id)
          end.not_to change(topic.comments, :count)
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
