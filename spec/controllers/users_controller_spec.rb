require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "render sign_up page" do
      get :new, user: {}

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "Adds a user to the database if valid user and redirects to home" do
      post :create, user: { username: 'username', password: 'password' }

      expect(User.find_by_credentials('username', 'password')).not_to be_nil
      expect(response).to redirect_to(root_url)
    end

    it "Does not add a user if username already exists in db, and render new" do
      User.create(username: 'username', password: 'password')
      post :create, user: { username: 'username', password: 'password' }

      expect(response).to render_template("new")
      expect(flash.now[:errors]).to be_present
    end
  end
end
