require 'rails_helper'

RSpec.describe 'Topics', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:topic) { create(:topic, user: user) }

  describe "新規トピック作成機能" do
    before do
      sign_in user
      visit new_topic_path
    end

    example '正しいページが表示されること' do
      expect(page).to have_content "新規トピック作成"
    end

    context '入力値が正しい場合' do
      example '新規登録が成功すること', js: true do
        expect do
          within(".topic-form") do
            fill_in 'topic[title]', with: 'testトピック'
            fill_in 'topic[description]', with: 'これはtestトピックです'
            fill_in 'tag', with: 'テストカテゴリー'
            click_button '作成する'
          end
        end.to change(Topic, :count).by(1)
        expect(page).to have_content '新しいトピックが登録されました!'
      end
    end

    context '入力値が正しくない場合' do
      example '新規登録が失敗すること', js: true do
        expect do
          within(".topic-form") do
            fill_in 'topic[title]', with: ''
            fill_in 'topic[description]', with: 'これはtestトピックです'
            fill_in 'tag', with: 'テストカテゴリー'
            click_button '作成する'
          end
        end.to change(Topic, :count).by(0)
        expect(page).to have_content '新しいトピックの登録に失敗しました。'
      end
    end
  end

  describe "トピック編集機能" do
    context 'トピック所有者の場合' do
      before do
        sign_in user
        visit topic_path(topic.id)
      end

      example '編集ボタンが表示されること' do
        expect(page).to have_link "編集"
      end

      context '正しい入力値' do
        example 'トピックが更新できること', js: true do
          click_on '編集'
          within(".topic-form") do
            fill_in 'topic[title]', with: 'testトピック更新'
            fill_in 'tag', with: 'newカテゴリー'
            click_on '更新する'
          end
          expect(page).to have_content 'トピックが更新されました！'
          expect(page).to have_current_path topic_path(topic.id)
          expect(topic.reload.title).to eq 'testトピック更新'
        end
      end
    end

    context 'トピック所有者でない場合' do
      before do
        sign_in other_user
        visit topic_path(topic.id)
      end

      example '編集ボタンが表示されないこと' do
        expect(page).not_to have_link "編集"
      end
    end
  end

  describe "トピック削除機能" do
    context 'トピック所有者の場合' do
      before do
        sign_in user
        visit topic_path(topic.id)
      end

      example '削除ボタンが表示されること' do
        expect(page).to have_link "削除"
      end

      example 'トピックが削除できること', js: true do
        within(".topic-show-edit") do
          click_on '削除'
        end
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'トピックが削除されました。'
        expect(user.topics.count).to eq 0
      end
    end

    context 'トピック所有者でない場合' do
      before do
        sign_in other_user
        visit topic_path(topic.id)
      end

      example '削除ボタンが表示されないこと' do
        expect(page).not_to have_link "削除"
      end
    end
  end
end
