require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    user = User.create(name: 'Anything', photo: 'http://licalhost:3000/anything.jpg', bio: 'Anything test',
                       posts_counter: 0)
    Post.create(author: user, title: 'post', text: 'This is my post', comments_counter: 0, likes_counter: 0)
    it 'returns http success' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end
    it 'includes correct placeholder text in the response body' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('List Recent Posts of a User')
    end
  end

  describe 'GET /show' do
    user = User.create(name: 'Anything', photo: 'http://licalhost:3000/anything.jpg', bio: 'Anything test',
                       posts_counter: 0)
    post = Post.create(author: user, title: 'post', text: 'This is my post', comments_counter: 0, likes_counter: 0)
    it 'returns http success' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
    end
    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end
    it 'includes correct placeholder text in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Selected Post of a User')
    end
  end
end
