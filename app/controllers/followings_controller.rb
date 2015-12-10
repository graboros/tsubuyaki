class FollowingsController < ApplicationController
  before_action :authenticate_user!, only: %i(create destroy)

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
