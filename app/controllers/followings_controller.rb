class FollowingsController < ApplicationController
  before_action :authenticate_user!, only: %i(create destroy)
  before_action :set_user, only: %i(index followers_index)

  def index
    render "users/show"
  end

  def followers_index
    render "users/show"
  end

  def create
    current_user.following_relationships.find_or_create_by!(follower: get_follower)
  end

  def destroy
    current_user.following_relationships.find_by!(follower: get_follower).destroy
  end

private
  def get_follower
    User.find(params[:follower_id])
  end
end
