require 'rails_helper'

RSpec.describe 'Notificationモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment) }
  let(:notification) { user.notification.build(visited: other_user.id) }

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '自分が通知する側の関係性がN:1となっていること' do
        expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
      end
      it '自分が通知される側の関係性がN:1となっていること' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1となっていること' do
        expect(Notification.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Commentモデルとの関係' do
      it 'N:1となっていること' do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end
    end
  end

  describe '通知のテスト' do
    context '有効な内容で投稿する' do
      it "保存されること" do
        expect(notification).to be_valid
      end
    end

    context 'visitor_idカラムを空白で投稿する' do
      it "無効になること" do
        notification.visitor_id = nil
        expect(notification).to be_invalid
      end
    end

    context 'visited_idカラムを空白で投稿する' do
      it "無効になること" do
        notification.visited_id = nil
        expect(notification).to be_invalid
      end
    end
  end
end
