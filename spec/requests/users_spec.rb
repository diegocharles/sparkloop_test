require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    create(:user, first_name: "John", last_name: "Doe", email: "123@email.com")
    create(:user, first_name: "Annie", last_name: "Doe", email: "ann@email.com")
  end

  let(:user) { User.first }

  describe "GET /users" do
    it "fetchs the users list in JSON"  do
      get '/users.json'

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("John")
      expect(response.body).to include("Doe")
    end
  end

  describe "GET /users/:id" do
    it "fetchs the user in JSON"  do
      get "/users/#{user.id}.json"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("John")
      expect(response.body).to include("Doe")
    end
  end
end
