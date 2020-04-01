require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let(:test_user) { create(:user, :test) }
  
  describe "ユーザー一覧ページ" do
    context '管理ユーザー' do
      before do
        sign_in admin_user
        visit users_path
      end

      example 'deleteリンクが表示されること' do
        expect(page).to have_link "delete"
      end

      example 'ユーザーを削除できること', js: true do
        click_on "delete"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_current_path users_path
        expect(page).to have_content "ユーザーを削除しました"
      end
    end
  end

  describe "プロフィール編集機能" do
    context "一般ユーザー" do
      before do
        sign_in user
        visit user_path(user.id)
        click_on 'プロフィール編集'
      end

      example "プロフィール編集ページが表示されること" do
        expect(page).to have_current_path '/users/edit'
      end

      example "プロフィールの更新に成功すること" do
        fill_in '名前【必須】', with: 'New_name'
        fill_in 'メールアドレス【必須】', with: 'test@example.com'
        fill_in '現在のパスワード【必須】', with: 'foobar'
        click_button '更新'
        expect(page).to have_current_path user_path(user.id)
        expect(user.reload.name).to eq 'New_name'
        expect(page).to have_content "アカウント情報を変更しました。"
      end
    end

    context "テストユーザー" do
      before do
        sign_in test_user
        visit user_path(test_user.id)
        click_on 'プロフィール編集'
      end

      example "プロフィール編集ページへはアクセスできないこと" do
        expect(page).to have_current_path user_path(test_user.id)
        expect(page).to have_content "申し訳ありません。テストユーザーは編集できません。"
      end
    end
  end
end

