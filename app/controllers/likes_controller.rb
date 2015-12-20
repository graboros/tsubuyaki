class LikesController < ApplicationController
  before_action :set_user, only: %i(index)
  before_action :authenticate_user!, :set_tweet, only: %i(create destroy)

  def index
    @like_tweets = @user.like_tweets.page params[:likepage] || 1
    render "users/show"
  end

  def create
    current_user.likes.find_or_create_by!(like_tweet: @tweet)
  end

  def destroy
    current_user.likes.find_by!(like_tweet: @tweet).destroy
  end

private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
