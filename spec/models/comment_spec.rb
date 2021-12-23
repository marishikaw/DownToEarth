require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  let(:comment) { create(:comment) }

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっていること' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1となっていること' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっていること' do
        expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end

  describe '投稿のテスト' do
    context '有効な内容で投稿する' do
      it "保存されること" do
        expect(comment).to be_valid
      end
    end

    context 'post_idカラムを空白で投稿する' do
      it "無効になること" do
        comment.post_id = nil
        expect(comment).to be_invalid
      end
    end

    context 'user_idカラムを空白で投稿する' do
      it "無効になること" do
        comment.user_id = nil
        expect(comment).to be_invalid
      end
    end
  end

  describe 'バリデーションのテスト' do
    subject { comment.valid? }
    
    context 'commentカラム' do
      it '空欄でないこと' do
        comment.comment = ''
        is_expected.to eq false
      end      
      it '200文字以下であること: 200文字は〇' do
        comment.comment = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it "200文字以下であること: 201文字は×" do
        comment.comment = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
end
