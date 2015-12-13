class Retweeting < ActiveRecord::Base
  # リツイートされているツイートが削除されたとき、以下のdependentが働き、リツイートしているツイートを同時に削除する
  belongs_to :retweet, class_name: "Tweet", foreign_key: "tweet_id", dependent: :destroy
  belongs_to :retweeted, class_name: "Tweet", foreign_key: "retweeted_id"
  validates :tweet_id, uniqueness: { scope: :retweeted_id }
end
