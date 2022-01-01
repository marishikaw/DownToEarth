require "rails_helper"

RSpec.describe "ユーザー新規登録のテスト", type: :system do
  let(:user) { build(:user) }

  describe "新規登録機能のテスト" do
    describe "有効な内容で登録する" do
      it "トップ画面に遷移すること" do
        visit new_user_registration_path
        fill_in "user[email]", with: user.email
        fill_in "user[name]", with: user.name
        fill_in "user[password]", with: user.password
        click_button "登録する"
        expect(current_path).to eq root_path
        expect(page).to have_content("アカウント登録が完了しました。")
      end
    end

    describe "メールアドレスのテスト" do
      context "メールアドレスを空白で新規登録する" do
        it "登録に失敗すること" do
          visit new_user_registration_path
          fill_in "user[email]", with: nil
          fill_in "user[name]", with: user.name
          fill_in "user[password]", with: user.password
          click_button "登録する"
          expect(current_path).to eq users_path
          expect(page).to have_content("メールアドレスは必須です。")
        end
      end
      
      context "メールアドレスを「@」なしで新規登録する" do
        it "登録に失敗すること" do
          visit new_user_registration_path
          fill_in "user[email]", with: "test"
          fill_in "user[name]", with: user.name
          fill_in "user[password]", with: user.password
          click_button "登録する"
          expect(current_path).to eq users_path
        end
      end
    end

    describe "ユーザーネームのテスト" do
      context "ユーザーネームを空白で新規登録する" do
        it "登録に失敗すること" do
          visit new_user_registration_path
          fill_in "user[email]", with: user.email
          fill_in "user[name]", with: nil
          fill_in "user[password]", with: user.password
          click_button "登録する"
          expect(current_path).to eq users_path
          expect(page).to have_content("ユーザーネームは2文字以上で入力してください")
        end
      end
    end

    describe "パスワードのテスト" do
      context "パスワードを空白で新規登録する" do
        it "登録に失敗すること" do
          visit new_user_registration_path
          fill_in "user[email]", with: user.email
          fill_in "user[name]", with: user.name
          fill_in "user[password]", with: nil
          click_button "登録する"
          expect(current_path).to eq users_path
          expect(page).to have_content("パスワードは必須です。")
        end
      end
      context "パスワードを6文字より少ない文字数で新規登録する" do
        it "登録に失敗すること" do
          visit new_user_registration_path
          fill_in "user[email]", with: user.email
          fill_in "user[name]", with: user.name
          fill_in "user[password]", with: "aaaaa"
          click_button "登録する"
          expect(current_path).to eq users_path
          expect(page).to have_content("パスワードは6文字以上で入力してください")
        end
      end
    end
  end
end
