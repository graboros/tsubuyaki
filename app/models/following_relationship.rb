class FollowingRelationship < ActiveRecord::Base
  belongs_to :following, class_name: "User", foreign_key: "followed_id"
  belongs_to :follower, class_name: "User", foreign_key: "following_id"
end
