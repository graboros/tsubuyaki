class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :render_when_signed_in, only: [:index]

  def index
  end

  def timeline
  end

  def search
    @text = text_param["text"]

    unless @text.present?
      render 'timeline'
    end

  end

private
  def render_when_signed_in
    render 'timeline' if user_signed_in?
  end
  def text_param
    params.require(:home).permit(:text)
  end
end
