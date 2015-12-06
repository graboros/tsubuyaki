class RetweetingRelationship < ActiveRecord::Base
  belongs_to :retweet, class_name: "Tweet", foreign_key: "tweet_id"
  belongs_to :retweeted, class_name: "Tweet", foreign_key: "retweeted_id"
end
