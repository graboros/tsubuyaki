class TweetsController < ApplicationController
  before_action :set_tweet, only: %i(retweet unretweet)
  before_action :authenticate_user!

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save then
      redirect_to timeline_path;
    else

    end
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
