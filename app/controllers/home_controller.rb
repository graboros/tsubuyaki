class HomeController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  before_action :redirect_to_timeline, only: [:index]

  def index
  end

  def timeline
  end

private
  def redirect_to_timeline
    redirect_to timeline_url if user_signed_in?
  end
end
