require 'rails_helper'

RSpec.describe 'Topics', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let!(:topic) { create(:topic, user: user, updated_at: 3.day.ago.to_s) }
  let!(:other_topic) { create(:topic, updated_at: 2.day.ago.to_s) }
  let!(:topics) { create_list(:topic, 9, updated_at: 1.day.ago.to_s) }
  let!(:category) { create(:category, category_name: "ニュース") }
  let!(:topic_category) { create(:topic_category, topic: topic, category: category) }

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

    context '管理者の場合' do
      before do
        sign_in admin_user
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

    context '管理者の場合' do
      before do
        sign_in admin_user
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
  end

  describe "トピック一覧表示機能" do
    context 'カテゴリーが選択されているとき' do
      before do
        visit topics_path(category_id: category.id)
      end

      example '正しいカテゴリー名が表示されること' do
        expect(page).to have_content "トピック一覧"
        expect(page).to have_content "カテゴリー：#{category.category_name}"
      end

      example "選択したカテゴリーに属したトピックが表示されること" do
        expect(page).to have_link href: topic_path(topic.id)
      end

      example "選択したカテゴリーに属していないトピックは表示されないこと" do
        expect(page).not_to have_link href: topic_path(other_topic.id)
      end
    end

    context '検索ワードが入力されているとき', js: true do
      let!(:search_topic) { create(:topic, title: "検索テスト用トピックです") }

      before do
        visit root_path
        within("header") do
          fill_in 'トピック検索', with: '検索テスト'
          link = find('.search-btn')
          link.click
        end
      end

      example "検索ワードを含むトピックが表示されること" do
        expect(page).to have_link href: topic_path(search_topic.id)
      end

      example "検索ワードを含まないトピックは表示されないこと" do
        expect(page).not_to have_link href: topic_path(other_topic.id)
      end
    end

    context '何も選択されていないとき', js: true do
      before do
        visit topics_path
      end

      example "最新の10件のトピックが表示されること" do
        expect(page).to have_link href: topic_path(other_topic.id)
        expect(page).not_to have_link href: topic_path(topic.id)
        expect(page).to have_css '.topic-title', count: 10
      end
    end
  end
end
