class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :like_tweet, class_name: "Tweet", foreign_key: "tweet_id"
  validates :like_tweet, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true
end
