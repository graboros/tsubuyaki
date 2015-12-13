class TweetsController < ApplicationController
  before_action :set_tweet, only: %i(destroy retweet unretweet)
  before_action :authenticate_user!
  before_action :current_users_tweet, only: %i(destroy)

  def create
    if tweet_params[:content].present?
      @tweet = current_user.tweets.build(tweet_params)
      if @tweet.save 
        redirect_to timeline_path;
      else

      end
    else
      redirect_to timeline_path;
    end
  end

  def update
  end

  def destroy
    @tweet.destroy
  end

  def retweet
    @tweet = current_user.tweets.build()
    @retweet = @tweet.retweeting_relationships.build(retweeted: get_tweet)

    if @tweet.save
      redirect_to timeline_url, notice: 'リツイートしました'
    else

    end
  end

  def unretweet
    Tweet::unretweet(current_user.id, params[:id])
    redirect_to timeline_url, notice: "untetweet test"
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

  def get_tweet
    Tweet.find(params[:id])
  end
end
