class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      @timeline_tweets = current_user.timeline_tweets params[:page] || 1 
      render 'timeline' 
    end

  end

  def search
    @text = text_param["text"]

    unless @text.present?
      render 'timeline'
    end

  end

private
  def text_param
    params.require(:home).permit(:text)
  end
end
