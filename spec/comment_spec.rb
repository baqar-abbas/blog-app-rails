require_relative 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'must update comments counter by 1 on every new comment' do
    user = User.create(name: 'John', photo: 'https://example.com', bio: 'tttt', posts_counter: 0)
    post1 = Post.create(author: user, title: 'title1', text: 'text1', comments_counter: 1, likes_counter: 1)
    Comment.create(post: post1, author: user, Text: 'text1')
    expect(post1.comments_counter).to eq(1)
    Comment.create(post: post1, author: user, Text: 'text2')
    expect(post1.comments_counter).to eq(2)
  end
end
