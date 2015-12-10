class TweetsController < ApplicationController
  before_action :set_tweet, only: %i(retweet unretweet)
  before_action :authenticate_user!

  def create
    current_user.tweets.create(tweet_params)
    redirect_to timeline_path;
  end

  def update
  end

  def destroy
  end

  def retweet
    current_user.following_relationships.find_or_create_by!(follower: get_follower)
  end

  def unretweet
    current_user.following_relationships.find_by!(follower: get_follower).destroy
  end

private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
