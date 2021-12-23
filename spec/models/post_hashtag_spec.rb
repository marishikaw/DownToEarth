require 'rails_helper'

RSpec.describe 'PostHashtagモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっていること' do
        expect(PostHashtag.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Hashtagモデルとの関係' do
      it 'N:1となっていること' do
        expect(PostHashtag.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end

end
