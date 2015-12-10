class Retweeting < ActiveRecord::Base
  belongs_to :retweet, class_name: "Tweet", foreign_key: "tweet_id"
  belongs_to :retweeted, class_name: "Tweet", foreign_key: "retweeted_id"
  validates :tweet_id, uniqueness: { scope: :retweeted_id }
end
