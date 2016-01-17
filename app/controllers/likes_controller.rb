class LikesController < ApplicationController
  before_action :authenticate_user!, :set_tweet, only: %i(create destroy)
  before_action :set_user, only: %i(index)

  def index
    @like_tweets = @user.like_tweets.page(params[:likepage])
    render "users/show"
  end

  def create
    @like = current_user.likes.find_or_initialize_by(like_tweet: @tweet)
    unless @like.save
      render js: 'addAlert("いいねの登録に失敗しました");'
    end
  end

  def destroy
    current_user.likes.find_by!(like_tweet: @tweet).destroy
  end

private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
