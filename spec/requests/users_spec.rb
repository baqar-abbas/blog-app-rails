require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/index'
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end
    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('List Users')
    end
  end

  describe 'GET /show' do
    let(:user) { User.create(name: 'Stella', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Rusia.', posts_counter: 0, id: 1) }
    it 'returns http success' do
      get '/users/show'
      expect(response).to have_http_status(:success)
    end
    it 'renders the show template' do
      get "/users/id=#{user.id}"
      expect(response).to render_template(:show)
    end
    it 'includes correct placeholder text in the response body' do
      get "/users/id=#{user.id}"
      expect(response.body).to include('Specific User details')
    end
  end
end
