require 'rails_helper'

RSpec.describe 'Notificationモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment) }
  let(:active_notification) { user.active_notifications.create(visited_id: other_user.id, action: "post") }
  let(:passive_notification) { user.passive_notifications.create(visitor_id: other_user.id) }

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
end
