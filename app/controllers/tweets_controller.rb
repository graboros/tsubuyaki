class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: %i(destroy retweet unretweet)

  def create
    params = tweet_params

    if params[:content].present?
      @tweet = current_user.tweets.build(params)
      if @tweet.save 
        msg_option = { notice: "ツイートしました" }
      else
        msg_option = { alert: "ツイートに失敗しました" }
      end
    end

    redirect_to root_url, msg_option || {}
  end

  def destroy
    if current_user.own?(@tweet)
      @tweet.destroy
    else
      redirect_to root_url, alert: 'このツイートを削除できません' 
    end
  end

  def retweet

    @retweet = @tweet.retweets.find_or_initialize_by(user: current_user)
    if @retweet.new_record?
      @retweet.retweeting_relationships.build(retweeted: @tweet)
      @retweet.save
    end
  end

  def unretweet
    @tweet.unretweet(current_user)
  end

private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
