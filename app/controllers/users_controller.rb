class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page])
  end
end
