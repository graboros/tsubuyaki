class Following < ActiveRecord::Base
  belongs_to :following, class_name: "User", foreign_key: "following_id"
  belongs_to :follower, class_name: "User", foreign_key: "followed_id"
  validates :following, presence: true, uniqueness: { scope: :follower }
  validates :follower, presence: true
end
