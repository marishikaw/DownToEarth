require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっていること' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっていること' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっていること' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Relationshipモデルとの関係' do
      it '自分がフォローされる側の関係性が1:Nとなっていること' do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
      it '自分がフォローする側の関係性が1:Nとなっていること' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
      it '自分をフォローしている人が1:Nとなっていること' do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
      it '自分がフォローしている人が1:Nとなっていること' do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '自分が通知する側の関係性が1:Nとなっていること' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
      it '自分が通知される側の関係性が1:Nとなっていること' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end

  describe 'リレーション機能のテスト' do
    context 'user_id:1がuser_id:2をフォローする' do
      before do
        user.follow(other_user.id)
      end
      it 'フォローできること' do
        expect(user.following?(other_user)).to be_truthy
      end
    end

    context 'user_id:1をフォローした状態でuser_id:2をフォローする' do
      before do
        user.follow(other_user.id)
      end
      it '別ユーザーをフォローできること' do
        expect(user.following?(other_user)).to be_truthy
      end
    end

    context 'フォローを解除する' do
      before do
        user.follow(other_user.id)
      end
      it 'フォロー中のユーザーをフォロー解除できること' do
        user.unfollow(other_user.id)
        expect(user.following?(other_user)).to be_falsy
      end
    end

    context 'フォローの通知' do
      before do
        user.follow(other_user.id)
      end
      it '他のユーザーにフォローされた時に通知が行われること' do
        expect(other_user.create_notification_follow!(user)).to eq true
      end
    end
  end

  describe 'バリデーションのテスト' do
    subject { user.valid? }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '50文字以下であること: 50文字は〇' do
        user.introduction = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字は×' do
        user.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end
end
