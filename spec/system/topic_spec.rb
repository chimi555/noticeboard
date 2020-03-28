require 'rails_helper'

RSpec.describe 'Topic', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit new_topic_path
  end

  describe "新規トピック作成" do
    example '正しいページが表示されること' do
      expect(page).to have_content "新規トピック作成"
    end

    context '正しい入力値' do
      example '新規登録が成功すること' do
        expect do
          within(".topic-form") do
            fill_in 'topic[title]', with: 'testトピック'
            fill_in 'topic[description]', with: 'これはtestトピックです'
            click_button '作成する'
          end
        end.to change(Topic, :count).by(1)
        expect(page).to have_content '新しいトピックが登録されました!'
      end
    end

    context '正しくない入力値' do
      example '新規登録が失敗すること' do
        expect do
          within(".topic-form") do
            fill_in 'topic[title]', with: ''
            fill_in 'topic[description]', with: 'これはtestトピックです'
            click_button '作成する'
          end
        end.to change(Topic, :count).by(0)
        expect(page).to have_content '新しいトピックの登録に失敗しました。'
      end
    end 
  end
end
