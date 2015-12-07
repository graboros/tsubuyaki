class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :redirect_when_signed_in, only: [:index]

  def index
  end

  def timeline
  end

private
  def redirect_when_signed_in
    redirect_to timeline_url if user_signed_in?
  end
end
