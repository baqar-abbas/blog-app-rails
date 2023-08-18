require_relative 'rails_helper'

RSpec.describe User, type: :model do
  # tests go here
  subject do
    User.new(
      name: 'John Doe',
      photo: 'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
      bio: 'Hello I am a test user',
      posts_counter: 0
    )
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'Check name to not be empty' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Check post counter is numeric' do
      subject.posts_counter = 'test'
      expect(subject).to_not be_valid
    end

    it 'Check post counter is greater than or equal to 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'is valid without a photo' do
      subject.photo = ''
      expect(subject).to be_valid
    end

    it 'must return recent posts as per given arguments' do
      user = User.create(name: 'John', photo: 'https://example.com', bio: 'tttt', posts_counter: 1)
      post1 = Post.create(author: user, title: 'title1', text: 'text1', comments_counter: 1, likes_counter: 1)
      post2 = Post.create(author: user, title: 'title2', text: 'text2', comments_counter: 1, likes_counter: 1)
      post3 = Post.create(author: user, title: 'title3', text: 'text3', comments_counter: 1, likes_counter: 1)
      expect(user.recent_posts(3)).to eq([post3, post2, post1])
    end
  end
end
