require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }

  describe "#show" do
    example 'レスポンスが正常に表示されること' do
      sign_in user
      get user_path(user.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "#index" do
    context '管理ユーザー' do
      before do
        sign_in admin_user
        get users_path
      end
      
      example 'レスポンスが正常に表示されること' do
        expect(response).to have_http_status(200)
      end
    end

    context '管理ユーザーでないユーザー' do
      before do
        sign_in user
        get users_path
      end

      example 'homeにリダイレクトされること' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
