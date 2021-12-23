require 'rails_helper'

RSpec.describe 'Hashtagモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'PostHashtagモデルとの関係' do
      it '1:Nとなっていること' do
        expect(Hashtag.reflect_on_association(:post_hashtags).macro).to eq :has_many
      end
    end
  end
end
