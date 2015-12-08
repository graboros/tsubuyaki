class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i(follow unfollow)
  before_action :set_user, only: %i(show)

  def show
  end

  def follow
    current_user.following_relationships.create(follower: get_follower)
  end

  def unfollow
    current_user.following_relationships.find_by(follower: get_follower).destroy
  end


private
  def set_user
    @user = User.find(params[:id])
  end

  def get_follower
    User.find(params[:follower_id])
  end
end
