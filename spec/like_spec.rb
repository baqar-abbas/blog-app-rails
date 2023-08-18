require_relative 'rails_helper'

RSpec.describe Like, type: :model do
  it 'must update likes counter by 1 on every new like' do
    user = User.create(name: 'John', photo: 'https://example.com', bio: 'tttt', posts_counter: 0)
    post1 = Post.create(author: user, title: 'title1', text: 'text1', comments_counter: 1, likes_counter: 1)
    Like.create(post: post1, author: user)
    expect(post1.likes_counter).to eq(1)
    Like.create(post: post1, author: user)
    expect(post1.likes_counter).to eq(2)
  end
end
