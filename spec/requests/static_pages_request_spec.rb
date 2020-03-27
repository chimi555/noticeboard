require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET" do
    example 'レスポンスが正常に表示されること' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
