require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  let(:post) { FactoryBot.create(:post) }

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっていること' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'PostImageモデルとの関係' do
      it '1:Nとなっていること' do
        expect(Post.reflect_on_association(:post_images).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっていること' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっていること' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'PostHahtagsモデルとの関係' do
      it '1:Nとなっていること' do
        expect(Post.reflect_on_association(:post_hashtags).macro).to eq :has_many
      end
    end

    context 'Hahtagsモデルとの関係' do
      it '1:Nとなっていること' do
        expect(Post.reflect_on_association(:hashtags).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっていること' do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end

  describe '#create' do
    before do
      @user = FactoryBot.create(:user)
    end
  
    it "is valid with a name, images" do
      post = FactoryBot.build(:post)
      post.valid?
      expect(post).to be_valid
    end
  end

  describe 'いいね機能のテスト' do
    describe 'メソッドのテスト' do
      context 'user_id:1がpost_id:1にいいねする' do
        before do
          post.user.favorites.create(post_id: post.id)
        end
        it 'いいねができること' do
          expect(user.following?(other_user)).to be_truthy
        end
      end
    end

  end

  describe 'バリデーションのテスト' do
    subject { post.valid? }

    context 'captionカラム' do
      it '500文字以下であること: 500文字は〇' do
        post.caption = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
      end
      it '500文字以下であること: 501文字は×' do
        post.caption = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end
end
