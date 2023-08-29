require 'rails_helper'
RSpec.describe 'User Show Page', type: :feature do
  describe 'Viewing user show page' do
    before(:each) do
      @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                           posts_counter: 0)
      @first_post = Post.create(author: @user1, title: 'post1', text: 'This is my first post', comments_counter: 0,
                                likes_counter: 0)
      @second_post = Post.create(author: @user1, title: 'post2', text: 'This is my second post', comments_counter: 0,
                                 likes_counter: 0)
      @third_post = Post.create(author: @user1, title: 'post3', text: 'This is my third post', comments_counter: 0,
                                likes_counter: 0)
      @fourth_post = Post.create(author: @user1, title: 'post4', text: 'This is my fourth post', comments_counter: 0,
                                 likes_counter: 0)
      visit "/users/#{@user1.id}"
    end

    it 'shows the user name' do
      expect(page).to have_content(@user1.name)
    end

    it 'should confirm user photo' do
      expect(page).to have_selector('img[alt="User Profile Picture"]')
    end

    it 'should show user bio' do
      expect(page).to have_content(@user1.bio)
    end

    it 'should show posts_counter for user' do
      expect(page).to have_content(@user1.posts_counter)
    end

    it "I can see the user's first 3 posts." do
      Post.create(
        [
          {
            author: @user1, title: 'First Post', text: 'My first post'
          },
          {
            author: @user1, title: 'Second Post', text: 'My Second post'
          },
          {
            author: @user1, title: 'Third Post', text: 'My Third post'
          }
        ]
      )
      page.has_content?(@user1.posts)
    end

    it 'should have a link to see all posts' do
      expect(page.html).to include('See all posts')
    end

    it 'should have a link to create a new post' do
      expect(page.html).to include('Create New Post')
    end

    it 'should redirect to post show page when clicking on post.' do
      visit user_posts_path(@user1)
      click_link @first_post.title
      expect(page).to have_current_path(user_post_path(@user1, @first_post))
    end

    it 'should show next_path when clicked on see all posts' do
      click_on 'See all posts'
      expect(current_path).to eq(user_posts_path(@user1))
    end
  end
end
