class UsersController < ApplicationController
  before_action :set_user, only: %i(show)

  def show
    @tweets = @user.tweets.page params[:page] || 1
  end
private
  def set_user
    @user = User.find(params[:id])
  end
end
