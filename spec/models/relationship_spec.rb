require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:relationship) { user.relationships.build(followed_id: other_user.id) }

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっていること' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
      it 'N:1となっていること' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end

  describe 'リレーションのテスト' do
    context 'follower_idとfollowed_idが存在する状態でいいねする' do
      it "保存されること" do
        expect(relationship).to be_valid
      end
    end

    context 'follower_idカラムを空白で投稿する' do
      it "無効になること" do
        relationship.follower_id = nil
        expect(relationship).to be_invalid
      end
    end

    context 'followed_idカラムを空白で投稿する' do
      it "無効になること" do
        relationship.followed_id = nil
        expect(relationship).to be_invalid
      end
    end
  end
end
