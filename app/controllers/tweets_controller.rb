class TweetsController < ApplicationController
  before_action :set_tweet, only: %i(destroy retweet unretweet)
  before_action :authenticate_user!
  before_action :current_users_tweet, only: %i(destroy)

  def create
    params = tweet_params
    if params[:content].present?
      @tweet = current_user.tweets.build(params)
      if @tweet.save 
        redirect_to root_url, notice: "ツイートに成功しました"
      else
        redirect_to root_url, alert: "ツイート失敗しました"
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
    redirect_to root_url, alert: 'このツイートを更新または削除できません' unless @tweet.user == current_user
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
