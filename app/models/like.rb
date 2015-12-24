class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :like_tweet, class_name: "Tweet", foreign_key: "tweet_id"
  validates :tweet_id, uniqueness: { scope: :user_id }
end
