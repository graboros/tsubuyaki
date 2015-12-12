class LikesController < ApplicationController
  before_action :set_tweet, only: %i(create destroy)
  before_action :authenticate_user!

  def create
     current_user.likes.find_or_create_by!(like_tweet: @tweet)
     redirect_to timeline_url, notice: 'いいねしました'

  end

  def destroy
     current_user.likes.find_by!(like_tweet: @tweet).destroy
    redirect_to timeline_url, notice: 'いいねを解除しました'
  end

private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
