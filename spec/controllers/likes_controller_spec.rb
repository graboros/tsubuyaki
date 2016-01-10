require 'rails_helper'

RSpec.describe LikesController, :type => :controller do
  before do
    @user2 = create(:user2)
    @tweet1 = create(:tweet1, user: @user2)
    @tweet2 = create(:tweet1, user: @user2)
  end

  describe "GET #index" do
    login_user

    it "populates an array of the tweets that the current_user likes" do
      create(:like, user: subject.current_user, like_tweet: @tweet1)
      create(:like, user: subject.current_user, like_tweet: @tweet2)
      get :index, user_id: subject.current_user
      expect(assigns(:like_tweets)).to match_array([@tweet1, @tweet2])
    end

    it "renders the users/show template" do
      get :index, user_id: subject.current_user
      expect(response).to render_template "users/show"
    end

    it "assigns the requested user to @user" do
      get :index, user_id: subject.current_user
      expect(assigns(:user)).to eq subject.current_user
    end

  end

  describe "POST #create" do

    context "when signed-in" do
      login_user

      context "with not liked tweet" do
        it "saves the new like in the database" do
          expect {
            post :create, user_id: @tweet1.user, id: @tweet1.id, format: 'js'
          }.to change(Like, :count).by(1)
        end
      end

      context "with already liked tweet" do
        it "does not save the new like in the database" do
          create(:like, user: subject.current_user, like_tweet: @tweet1)
          expect {
            post :create, user_id: @tweet1.user, id: @tweet1.id, format: 'js'
          }.not_to change(Retweeting, :count)
        end
      end

      it "assigns the requested tweet to @tweet" do
        post :create, user_id: @tweet1.user, id: @tweet1.id, format: 'js'
        expect(assigns(:tweet)).to eq @tweet1
      end

      it "renders to the :create template" do
        post :create, user_id: @tweet1.user, id: @tweet1.id, format: 'js'
        expect(response).to render_template :create
      end

    end

    context "when not signed-in" do
      it "does not save the new like in the database" do
        expect {
          post :create, user_id: @tweet1.user, id: @tweet1.id, format: 'js'
        }.not_to change(Like, :count)
      end
    end

  end

  describe "DESTROY#destroy" do

    context "when signed-in" do
      login_user

      before do
        create(:like, user: subject.current_user, like_tweet: @tweet1)
      end

      it "deletes the like in the database" do
        expect {
          delete :destroy, user_id: @tweet1.user, id: @tweet1.id, format: 'js'
        }.to change(Like, :count).by(-1)
      end

      it "render to the :destroy template" do
        delete :destroy, user_id: @tweet1.user.id, id: @tweet1.id, format: 'js'
        expect(response).to render_template :destroy
      end
    end

    context "when not signed-in" do
      it "does not delete the like in the database" do
        @user1 = build(:user1)
        create(:like, user: @user1, like_tweet: @tweet1)
        expect {
          delete :destroy, user_id: @tweet1.user, id: @tweet1.id, format: 'js'
        }.not_to change(Like, :count)
      end
    end

  end
end
