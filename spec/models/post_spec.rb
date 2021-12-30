require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let!(:other_user) { FactoryBot.create(:user) }
  let!(:other_post) { FactoryBot.create(:post, user: other_user) }  

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

  describe 'いいね機能のテスト' do
    context 'user_id:1がpost_id:1に対していいねをする' do
      before do
        user.favorites.create(post_id: post.id)
      end
      it 'いいねできること' do
        expect(post.favorited_by?(user)).to eq true
      end
    end

    context 'user_id:1がpost_id:1に対していいね済みかどうかを確認' do
      before do
        user.favorites.create(post_id: post.id)
      end
      it 'いいね済みであること' do
        expect(post.favorited_by?(user)).to eq true
      end
      it 'いいね済みでないこと' do
        user.favorites.find_by(post_id: post.id).destroy
        expect(post.favorited_by?(user)).to eq false
      end
    end
  end

  describe '通知機能のテスト' do
    context 'いいねの通知テスト' do
      context 'user_id:1がuser_id:2の投稿に対していいねをする' do
        before do
          user.favorites.create(post_id: other_post.id)
        end
        it 'いいねできること' do
          expect(other_post.favorited_by?(user)).to eq true
        end
      end

      context 'user_id:1がuser_id:2の投稿に対していいねした時に通知を作成する' do
        before do
          user.favorites.create(post_id: other_post.id)
        end
        it 'いいねの通知が作成されること' do
          expect(other_post.create_notification_favorite!(user)).to eq true
        end
      end
    end

    context 'コメントの通知テスト' do
      context 'user_id:1がuser_id:2の投稿に対してコメントをする' do
        it 'コメントできること' do
          expect{ other_post.comments.create(post_id: other_post.id, user_id: user.id, comment: 'Test') }
          .to change{ Comment.count }.by(1)
        end
      end

      context 'user_id:1がuser_id:2の投稿に対してコメントした時に通知を作成する' do
        before do
          other_post.comments.create(post_id: other_post.id, user_id: user.id, comment: 'Test')
        end
        it 'コメントの通知が作成されること' do
          expect(other_post.create_notification_comment!(user, user.comments)).to eq true
        end
      end
    end
  end

  describe 'ハッシュタグのテスト' do
    describe 'キャプションにハッシュタグを2つを入れて投稿する' do
      it 'ハッシュタグが2つ作成される' do
        expect{  create(:post, user: user, caption: "#test #test2") }
        .to change{ Hashtag.count }.by(2)
      end
    end
  end
end
