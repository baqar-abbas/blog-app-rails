require 'rails_helper'

RSpec.describe 'Post show Page', type: :feature do
    describe 'Viewing Post Show page' do
        before(:each) do
            @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                                 posts_counter: 0)
            @first_post = Post.create(author: @user1, title: 'post1', text: 'This is my first post', comments_counter: 0,
                 likes_counter: 0)
            @comment1 = Comment.create(post: @first_post, author: @user1, Text: 'Hi Tom!, Nice comment')
      
            visit user_post_path(@user1, @first_post)
          end

          it 'should show post title' do
            expect(page).to have_content(@first_post.title)
          end

          it 'should show post author' do
            expect(page).to have_content(@user1.name)
          end

          it 'should show comments counter' do
            expect(page).to have_content(@first_post.comments_counter)
          end

          
    end
end