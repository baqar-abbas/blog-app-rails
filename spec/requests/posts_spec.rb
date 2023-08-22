require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       id: 1)
    Post.create(author: user, title: 'Hello', text: 'This is my first post', id: 1)
    it 'returns http success' do
      get '/users/:id/posts'
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      get '/users/1/posts'
      expect(response).to render_template(:index)
    end
    it 'includes correct placeholder text in the response body' do
      get '/users/1/posts'
      expect(response.body).to include('List All Posts of a User')
    end
  end

  describe 'GET /show' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       id: 1)
    Post.create(author: user, title: 'Hello', text: 'This is my first post', id: 1)
    it 'returns http success' do
      get '/users/:user_id/posts/:id'
      expect(response).to have_http_status(:success)
    end
    it 'renders the show template' do
      get '/users/:user_id/posts/:id'
      expect(response).to render_template(:show)
    end
    it 'includes correct placeholder text in the response body' do
      get '/users/:user_id/posts/:id'
      expect(response.body).to include('Specific Post of a User')
    end
  end
end
