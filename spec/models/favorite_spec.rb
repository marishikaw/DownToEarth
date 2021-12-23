require 'rails_helper'

RSpec.describe 'Favoriteモデルのテスト', type: :model do
  let(:favorite) { create(:favorite) }

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっていること' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1となっていること' do
        expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end

  describe 'いいねのテスト' do
    context 'user_idとpost_idが存在する状態でいいねする' do
      it "保存されること" do
        expect(favorite).to be_valid
      end
    end

    context 'post_idカラムを空白で投稿する' do
      it "無効になること" do
        favorite.post_id = nil
        expect(favorite).to be_invalid
      end
    end

    context 'user_idカラムを空白で投稿する' do
      it "無効になること" do
        favorite.user_id = nil
        expect(favorite).to be_invalid
      end
    end
  end
end
