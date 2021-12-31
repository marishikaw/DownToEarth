require "rails_helper"

RSpec.describe "ユーザーログインのテスト", type: :system do
  let(:user) { create(:user) }

  describe "ログイン機能のテスト" do
    context "有効な内容でログインする" do
      it "トップ画面に遷移すること" do
        visit new_user_session_path
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        expect(current_path).to eq root_path
        expect(page).to have_content("ログインしました。")
      end
    end

    context "誤ったメールアドレスでログインする" do
      it "ログインに失敗すること" do
        visit new_user_session_path
        fill_in "user[email]", with: "sample@example.com"
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content("メールアドレス もしくはパスワードが不正です。")
      end
    end
    
    context "誤ったパスワードでログインする" do
      it "ログインに失敗すること" do
        visit new_user_session_path
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: "Example123"
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content("メールアドレス もしくはパスワードが不正です。")
      end
    end
  end
end