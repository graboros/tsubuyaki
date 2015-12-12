class TweetsController < ApplicationController
  before_action :set_tweet, only: %i(destroy retweet unretweet)
  before_action :authenticate_user!
  before_action :current_users_tweet, only: %i(destroy)

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
    @tweet.destroy
    redirect_to timeline_url, notice: 'ツイートを削除しました'
  end

  def retweet
    current_user.following_relationships.find_or_create_by!(follower: get_follower)
  end

  def unretweet
    current_user.following_relationships.find_by!(follower: get_follower).destroy
  end

private
  def  current_users_tweet
    if @tweet.user != current_user
       redirect_to timeline_url, notice: 'このツイートを更新または削除できません'
    end
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
