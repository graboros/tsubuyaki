class TweetsController < ApplicationController
  before_action :set_tweet, only: %i(destroy retweet unretweet)
  before_action :authenticate_user!
  before_action :current_users_tweet, only: %i(destroy)

  def create
    if tweet_params[:content].present?
      @tweet = current_user.tweets.build(tweet_params)
      if @tweet.save 
        redirect_to root_url
      else

      end
    else
      redirect_to root_url
    end
  end

  def destroy
    @tweet.destroy
  end

  def retweet
    @retweet = current_user.tweets.build()
    @retweeted = @retweet.retweeting_relationships.build(retweeted: @tweet)
    @retweet.save
  end

  def unretweet
    Tweet::unretweet(current_user.id, @tweet)
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
