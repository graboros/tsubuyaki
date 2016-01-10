require 'rails_helper'

RSpec.describe TweetsController, :type => :controller do
  describe "POST #create" do
    login_user

    context "with valid attributes " do
      it "saves the new tweet in the database" do
        expect {
          post :create, user_id: subject.current_user.id, tweet: attributes_for(:tweet1)
        }.to change(Tweet, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new tweet in the database" do
        expect {
          post :create, user_id: subject.current_user.id, tweet: attributes_for(:too_long_tweet)
        }.not_to change(Tweet, :count)
      end
    end

    context "without the content" do

      it "does not save the new tweet in the database" do
        expect {
          post :create, user_id: subject.current_user.id, tweet: attributes_for(:tweet1, content: "")
        }.not_to change(Tweet, :count)
      end
    end

    it "redirects to the root_url" do
      post :create, user_id: subject.current_user.id, tweet: attributes_for(:tweet1, content: "")
      expect(response).to redirect_to root_url
    end
  end

  describe "DELETE #destroy" do
    login_user

    before :each do
      @tweet = create(:tweet1, user: subject.current_user)
      @other = create(:user2)
      @others_tweet = create(:tweet1, user: @other)
    end

    context "with the own tweet" do
      it "deletes the tweet" do
        expect {
          delete :destroy, user_id: @tweet.user.id, id: @tweet.id, format: 'js'
        }.to change(Tweet, :count).by(-1)
      end

      it "render to the :destroy template" do
        delete :destroy, user_id: @tweet.user.id, id: @tweet.id, format: 'js'
        expect(response).to render_template :destroy
      end
    end

    context "with the other's tweet" do
      it "does not delete the tweet" do
        expect {
          delete :destroy, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
        }.not_to change(Tweet, :count)
      end

      it "redirects to the root_url" do
        delete :destroy, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "POST #retweet" do
    login_user

    before :each do
      @other = create(:user2)
      @others_tweet = create(:tweet1, user: @other)
    end

    context "with not retweeted" do
      it "saves the new retweet in the database" do
        expect {
          post :retweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
        }.to change(Retweeting, :count).by(1)
      end
    end

    context "with already retweeted" do
      it "does not save the new retweet in the database" do
        post :retweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
        expect {
          post :retweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
        }.not_to change(Retweeting, :count)
      end
    end

    it "render to the :retweet template" do
      post :retweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
      expect(response).to render_template :retweet
    end
  end

  describe "POST #unretweet" do
    login_user

    before :each do
      @other = create(:user2)
      @others_tweet = create(:tweet1, user: @other)
    end

    context "with not unretweeted" do
      it "deletes the retweet" do
        post :retweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
        expect {
          post :unretweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
        }.to change(Retweeting, :count).by(-1)
      end
    end

    context "with already unretweeted" do
      it "does not delete the retweet" do
        post :retweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
        post :unretweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
        expect {
          post :unretweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
        }.not_to change(Retweeting, :count)
      end
    end

    it "render to the :unretweet template" do
      post :retweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
      post :unretweet, user_id: @others_tweet.user.id, id: @others_tweet.id, format: 'js'
      expect(response).to render_template :unretweet
    end
  end
end
