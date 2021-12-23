require 'rails_helper'

RSpec.describe 'PostImageモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっていること' do
        expect(PostImage.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end

end
