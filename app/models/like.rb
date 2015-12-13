class Like < ActiveRecord::Base
  default_scope { order(created_at: :desc) }
  belongs_to :user
  belongs_to :like_tweet, class_name: "Tweet", foreign_key: "tweet_id"
end
