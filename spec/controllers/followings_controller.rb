require 'rails_helper'

RSpec.describe FollowingsController, :type => :controller do
  before do
    @user2 = create(:user2)
  end

  describe "GET #index" do
    login_user

    before do
      create(:following, following: subject.current_user, follower: @user2)
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

  describe "GET #followers_index" do
    login_user

    before do
      create(:following, following: subject.current_user, follower: @user2)
    end

    it "renders the users/show template" do
      get :followers_index, user_id: subject.current_user
      expect(response).to render_template "users/show"
    end

    it "assigns the requested user to @user" do
      get :followers_index, user_id: subject.current_user
      expect(assigns(:user)).to eq subject.current_user
    end

  end

  describe "POST #create" do

    context "when signed-in" do
      login_user

      context "with not following user" do
        it "saves the new following in the database" do
          expect {
            post :create, user_id: @user2.id, format: 'js'
          }.to change(Following, :count).by(1)
        end
      end

      context "with already following user" do
        it "does not save the new following in the database" do
          create(:following, following: subject.current_user, follower: @user2)
          expect {
            post :create, user_id: @user2.id, format: 'js'
          }.not_to change(Following, :count)
        end
      end

      it "assigns the requested user to @user" do
        post :create, user_id: @user2.id, format: 'js'
        expect(assigns(:user)).to eq @user2
      end

      it "renders to the :create template" do
        post :create, user_id: @user2.id, format: 'js'
        expect(response).to render_template :create
      end

    end

    context "when not signed-in" do
      it "does not save the new following in the database" do
        expect {
          post :create, user_id: @user2.id, format: 'js'
        }.not_to change(Following, :count)
      end
    end

  end

  describe "DESTROY#destroy" do

    context "when signed-in" do
      login_user

      before do
        @following = create(:following, following: subject.current_user, follower: @user2)
      end

      it "deletes the following in the database" do
        expect {
          delete :destroy, user_id: @user2.id, id: @following.id, format: 'js'
        }.to change(Following, :count).by(-1)
      end

      it "render to the :destroy template" do
        delete :destroy, user_id: @user2.id, id: @following.id, format: 'js'
        expect(response).to render_template :destroy
      end
    end

    context "when not signed-in" do
      it "does not delete the following in the database" do
        @user1 = build(:user1)
        @following = create(:following, following: @user1, follower: @user2)
        expect {
          delete :destroy, user_id: @user2.id, id: @following.id, format: 'js'
        }.not_to change(Following, :count)
      end
    end

  end
end
