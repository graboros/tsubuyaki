class User < ActiveRecord::Base
  has_many :tweets

  has_many :followed_relationships, class_name: "FollowingRelationship", foreign_key: "followed_id"
  has_many :followers, through: :followed_relationships
  has_many :following_relationships, class_name: "FollowingRelationship", foreign_key: "following_id"
  has_many :followings, through: :following_relationships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
