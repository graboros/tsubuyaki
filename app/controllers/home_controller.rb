class HomeController < ApplicationController

  def index
    if user_signed_in?
      @timeline_tweets = current_user.timeline_tweets.page(params[:page])
      render :timeline
    end
  end

  def search
    @text = text_param[:text]

    unless @text.present?
      redirect_to :back
    end
  end

private
  def text_param
    params.require(:home).permit(:text)
  end
end
