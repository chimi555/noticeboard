require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET #show" do
    example 'レスポンスが正常に表示されること' do
      sign_in user
      get user_path(user.id)
      expect(response).to have_http_status(200)
    end
  end
end
