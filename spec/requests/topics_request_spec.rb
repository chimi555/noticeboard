require 'rails_helper'

RSpec.describe "Topics", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:topic) { create(:topic, user: user) }
  let!(:other_topic) { create(:topic, user: other_user) }
  let(:topic_params) { { title: 'テストトピックタイトル', description: 'テストトピックです。' } }

  describe "#index" do
    before do
      get topics_path
    end

    example 'レスポンスが正常に表示されること' do
      expect(response).to have_http_status(200)
    end
  end

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
    let!(:category_list) { "ニュース" }

    context 'ログイン済ユーザー' do
      before do
        sign_in user
      end

      example '新しいトピックが登録できること' do
        expect do
          post topics_path, params: { topic: topic_params, category_list: category_list }
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

  describe '#edit' do
    context 'ログイン済ユーザー' do
      context 'トピック所有者の場合' do
        before do
          sign_in user
          get edit_topic_path(topic.id)
        end

        example 'レスポンスが正常に表示されること' do
          expect(response).to have_http_status(200)
        end
      end

      context 'トピック所有者でない場合' do
        before do
          sign_in other_user
          get edit_topic_path(topic.id)
        end

        example 'homeページにリダイレクトされる' do
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'ログインしていないユーザー' do
      example 'ログインページにリダイレクトされること' do
        get edit_topic_path(topic.id)
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#update' do
    let!(:category_list) { "医療" }

    context 'ログイン済ユーザー' do
      context 'トピック所有者の場合' do
        before do
          sign_in user
        end

        example '自分のトピックを更新できる' do
          topic_params = attributes_for(:topic, {
            title: 'テストトピックタイトル更新',
          })
          patch topic_path(topic.id), params: { topic: topic_params, category_list: category_list }
          expect(topic.reload.title).to eq 'テストトピックタイトル更新'
          expect(response).to redirect_to topic_path(topic)
        end
      end

      context 'トピック所有者でない場合' do
        before do
          sign_in other_user
        end

        example 'homeページにリダイレクトされる' do
          topic_params = attributes_for(:topic, {
            title: 'テストトピックタイトル更新',
          })
          patch topic_path(topic.id), params: { topic: topic_params }
          expect(topic.reload.title).not_to eq 'テストトピックタイトル更新'
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'ログインしていないユーザー' do
      example 'ログインページにリダイレクトされること' do
        patch topic_path(topic.id)
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#destroy' do
    context 'ログイン済ユーザー' do
      context 'トピック所有者の場合' do
        before do
          sign_in user
        end

        example 'トピックを削除できる' do
          expect do
            delete topic_path(topic.id)
          end.to change(user.topics, :count).by(-1)
          expect(response).to redirect_to user_path(user)
        end
      end

      context 'トピック所有者でない場合' do
        before do
          sign_in other_user
        end

        example 'homeページにリダイレクトされる' do
          expect do
            delete topic_path(topic.id)
          end.to change(user.topics, :count).by(0)
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
