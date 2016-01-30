class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: %i(destroy retweet unretweet)

  def create
    @tweet = current_user.tweets.build(tweet_params)

    unless @tweet.save
      render js: 'addAlert("ツイートに失敗しました");'
    end
  end

  def destroy
    if current_user.own?(@tweet)
      @tweet.destroy
    else
      render js: 'addAlert("このツイートは削除できません");'
    end
  end

  def retweet
    @retweet = current_user.tweets.find_or_initialize_by(retweet: @tweet)

    unless @retweet.save
      render js: 'addAlert("リツイートに失敗しました");'
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
