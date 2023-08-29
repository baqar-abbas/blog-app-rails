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
    # sleep 1  # Introduce a short delay to allow time for the posts to be displayed   
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
  
    end
end