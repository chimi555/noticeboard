require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:topic) { create(:topic, user: user) }

  describe "コメント投稿機能" do
    before do
      sign_in other_user
      visit topic_path(topic.id)
    end

    context 'ログインユーザー' do
      example 'コメント投稿が成功すること' do
        expect do
          within(".topic-comment-form") do
            fill_in 'comment[content]', with: 'テストコメントです！'
            click_on '投稿'
          end
        end.to change(topic.comments, :count).by(1)
        expect(page).to have_content '新しいコメントを投稿しました!'
        expect(page).to have_content 'テストコメントです！'
      end
    end
  end

  describe "コメント削除機能" do
    let!(:comment) { create(:comment, user: user, topic: topic) }

    context 'コメント所有者の場合' do
      before do
        sign_in user
        visit topic_path(topic.id)
      end

      example '削除ボタンが表示されること' do
        within(".comment") do
          expect(page).to have_link "削除"
        end
      end

      example 'コメントが削除できること', js:true do
        within(".comment") do
          click_on '削除'
        end
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'コメントを削除しました。'
        expect(topic.comments.count).to eq 0
      end
    end

    context 'コメント所有者でない場合' do
      before do
        sign_in other_user
        visit topic_path(topic.id)
      end

      example '削除ボタンが表示されないこと' do
        within(".comment") do
          expect(page).not_to have_link "削除"
        end
      end
    end
  end
end