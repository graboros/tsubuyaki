class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :render_when_signed_in, only: [:index]

  def index
  end

  def timeline
  end

  def search
  end

private
  def render_when_signed_in
    render 'timeline' if user_signed_in?
  end
end
