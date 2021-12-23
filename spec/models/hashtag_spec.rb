require 'rails_helper'

RSpec.describe 'Hashtagモデルのテスト', type: :model do
  let(:hashtag) { create(:hashtag, post_hashtag: post_hashtag) }

  describe 'アソシエーションのテスト' do
    context 'PostHashtagモデルとの関係' do
      it '1:Nとなっていること' do
        expect(Hashtag.reflect_on_association(:post_hashtags).macro).to eq :has_many
      end
    end

    context 'Postモデルとの関係' do
      it '1:Nとなっていること' do
        expect(Hashtag.reflect_on_association(:post).macro).to eq :has_many
      end
    end
  end

  describe 'バリデーションのテスト' do
    subject { hashtag.valid? }
    
    context 'nameカラム' do
      it '空欄でないこと' do
        hashtag.name = ''
        is_expected.to eq false
      end      
      it '25文字以下であること: 25文字は〇' do
        hashtag.name = Faker::Lorem.characters(number: 25)
        is_expected.to eq true
      end
      it "25文字以下であること: 26文字は×" do
        hashtag.name = Faker::Lorem.characters(number: 26)
        is_expected.to eq false
      end
    end
  end
end
