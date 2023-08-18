require_relative 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Baqar', posts_counter: 0) }
  subject do
    Post.new(author_id: user.id, title: 'Hello', text: 'This is my post', comments_counter: 1, likes_counter: 1)
  end

  context 'Testing validation' do
    it 'Title should be invalid with nil value' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'Title must not exceed 250 characters' do
      expect(subject.title.length).to be <= 250
    end

    it 'CommentsCounter must be an integer greater than or equal to zero.' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'LikesCounter must be an integer greater than or equal to zero.' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'LikesCounter must be an integer greater than or equal to zero.' do
      subject.likes_counter = 1
      expect(subject).to be_valid
    end
  end

  context 'Testing methods' do
    it 'must return recent comments as per given arguments' do
      user = User.create(name: 'John', photo: 'https://example.com', bio: 'tttt', posts_counter: 1)
      post1 = Post.create(author: user, title: 'title1', text: 'text1', comments_counter: 1, likes_counter: 1)
      comment1 = Comment.create(post: post1, author: user, Text: 'comment1')
      comment2 = Comment.create(post: post1, author: user, Text: 'comment2')
      comment3 = Comment.create(post: post1, author: user, Text: 'comment3')
      expect(post1.recent_comments(3)).to eq([comment3, comment2, comment1])
    end

    it 'must update post counter by 1 on every new post' do
      user = User.create(name: 'John', photo: 'https://example.com', bio: 'tttt')
      Post.create(author: user, title: 'title1', text: 'text1', comments_counter: 1, likes_counter: 1)
      expect(user.posts_counter).to eq(1)
      Post.create(author: user, title: 'title1', text: 'text1', comments_counter: 1, likes_counter: 1)
      expect(user.posts_counter).to eq(2)
    end
  end
end
