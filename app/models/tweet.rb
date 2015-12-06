class Tweet < ActiveRecord::Base
  belongs_to :user

  has_many :retweeting_relationships, class_name: "RetweetingRelationship", foreign_key: "retweeted_id"
  has_many :retweets, through: :retweeting_relationships
end
