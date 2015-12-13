class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy

  # 以下のdependentを入れることでリツイート解除された時に、リツイートしているというAssociationを削除できるようにする
  # Retweetingモデル側のリツイートされているツイートにdependent属性を指定しないことで、リツイートされているツイートを削除しないようにする
  has_many :retweeting_relationships, class_name: "Retweeting", foreign_key: "tweet_id", dependent: :destroy
  has_many :retweeteds, through: :retweeting_relationships

  # 以下のdependentを入れることでリツイートされているツイートが削除された時に、Associationを削除できるようにする
  # Retweetingモデル側のリツイートしているツイートにdependent属性を指定して、同時にリツイートしているツイートも削除する
  has_many :retweeted_relationships, class_name: "Retweeting", foreign_key: "retweeted_id", dependent: :destroy
  has_many :retweets, through: :retweeted_relationships

  def self.unretweet(user_id, tweet_id)
    # current_userから引くと以下のようにtweets経由で取りに行かないといけななり、ループにしないといけなくなりそうなので、しょうがないからSQLで消す
    # ? current_user.tweets.retweetings.find_by!(retweet: get_tweet).destroy_all
    self.where("tweets.user_id = ?", user_id).joins("LEFT JOIN retweetings On tweets.id = retweetings.tweet_id").where("retweetings.retweeted_id = ?", tweet_id).destroy_all
  end

end
