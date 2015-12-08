class User < ActiveRecord::Base
  has_one :profile

  has_many :tweets

  has_many :likes
  has_many :like_tweets, through: :likes

  has_many :followed_relationships, class_name: "FollowingRelationship", foreign_key: "followed_id"
  has_many :followers, through: :followed_relationships, source: :following
  has_many :following_relationships, class_name: "FollowingRelationship", foreign_key: "following_id"
  has_many :followings, through: :following_relationships, source: :follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def timeline_tweets
    timeline_users = self.followings.to_a << self
    Tweet.where(user: timeline_users).order(updated_at: :desc)
  end
end
