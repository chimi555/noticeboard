require 'rails_helper'

RSpec.describe "Topics", type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:topic_params) { { title: 'テストトピックタイトル', description: 'テストトピックです。' } }

  describe "#show" do
    before do
      get topic_path(topic.id)
    end

    example 'レスポンスが正常に表示されること' do
      expect(response).to have_http_status(200)
    end

    example 'インスタンス変数@topicが存在すること' do
      expect(assigns(:topic)).to eq topic
    end
  end

  describe '#new' do
    context 'ログイン済ユーザー' do
      before do
        sign_in user
        get new_topic_path
      end

      example 'レスポンスが正常に表示されること' do
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていないユーザー' do
      example 'ログインページにリダイレクトされること' do
        get new_topic_path
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#create' do
    context 'ログイン済ユーザー' do
      before do
        sign_in user
      end

      example '新しいトピックが登録できること' do
        expect do
          post topics_path, params: { topic: topic_params }
        end.to change(user.topics, :count).by(1)
      end
    end

    context 'ログインしていないユーザー' do
      example '新しいトピックが登録できないこと' do
        expect do
          post topics_path, params: { topic: topic_params }
        end.not_to change(user.topics, :count)
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
