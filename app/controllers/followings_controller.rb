class FollowingsController < ApplicationController
  before_action :authenticate_user!, :set_follower, only: %i(create destroy)
  before_action :set_user, only: %i(index followers_index)

  def index
    render "users/show"
  end

  def followers_index
    render "users/show"
  end

  def create
    @following = current_user.followed_relationships.find_or_initialize_by(following: @user)
    unless @following.save
      render js: 'addAlert("フォローに失敗しました");'
    end
  end

  def destroy
    current_user.followed_relationships.find_by!(following: @user).destroy
  end

private
  def set_follower
    @user = User.find(params[:user_id])
  end
end
