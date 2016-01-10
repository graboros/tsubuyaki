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
    current_user.following_relationships.find_or_create_by!(follower: @user)
  end

  def destroy
    current_user.following_relationships.find_by!(follower: @user).destroy
  end

private
  def set_follower
    @user = User.find(params[:user_id])
  end
end
