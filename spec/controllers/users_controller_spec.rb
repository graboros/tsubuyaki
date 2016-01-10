require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "GET #show" do
    login_user

    before do
      @tweet1 = create(:tweet1, user: subject.current_user)
      @tweet2 = create(:long_tweet, user: subject.current_user)
    end

    it "assigns the requested user to @user" do
      get :show, id: subject.current_user
      expect(assigns(:user)).to eq subject.current_user
    end

    it "assigns the requested user's tweets to @tweets" do
      get :show, id: subject.current_user
      expect(assigns(:tweets)).to match_array([@tweet1, @tweet2])
    end

    it "renders the :show template" do
      get :show, id: subject.current_user
      expect(response).to render_template :show
    end
  end
end
