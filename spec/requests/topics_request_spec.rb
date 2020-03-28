require 'rails_helper'

RSpec.describe "Topics", type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }

  describe "GET #show" do
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
end
