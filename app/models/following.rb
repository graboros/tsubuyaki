class Following < ActiveRecord::Base
  belongs_to :following, class_name: "User", foreign_key: "following_id"
  counter_culture :following, column_name: "followers_count"
  belongs_to :follower, class_name: "User", foreign_key: "followed_id"
  counter_culture :follower, column_name: "followings_count"
  validates :following, presence: true, uniqueness: { scope: :follower }
  validates :follower, presence: true
end
