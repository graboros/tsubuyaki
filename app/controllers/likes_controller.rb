class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i(create destroy)
  before_action :set_user, only: %i(index)

  def index
    @like_tweets = @user.like_tweets.page(params[:likepage])
    render "users/show"
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @like = current_user.likes.find_or_initialize_by(like_tweet: @tweet)
    unless @like.save
      render js: 'addAlert("いいねの登録に失敗しました");'
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
  end
end
