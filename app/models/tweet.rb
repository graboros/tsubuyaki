class Tweet < ActiveRecord::Base
  belongs_to :user
  counter_culture :user
  has_many :likes, dependent: :destroy

  # 以下のdependentを入れることでリツイート解除された時に、リツイートしているというAssociationを削除できるようにする
  # Retweetingモデル側のリツイートされているツイートにdependent属性を指定しないことで、リツイートされているツイートを削除しないようにする
  has_many :retweeting_relationships, class_name: "Retweeting", foreign_key: "tweet_id", dependent: :destroy
  has_many :retweeteds, through: :retweeting_relationships

  # 以下のdependentを入れることでリツイートされているツイートが削除された時に、Associationを削除できるようにする
  # Retweetingモデル側のリツイートしているツイートにdependent属性を指定して、同時にリツイートしているツイートも削除する
  has_many :retweeted_relationships, class_name: "Retweeting", foreign_key: "retweeted_id", dependent: :destroy
  has_many :retweets, through: :retweeted_relationships

  validates :user, presence: true
  validates :content, length: { maximum: 140 }

  # def self.unretweet(user, tweet)
  def unretweet(user)
    retweet = self.retweets.find_by(user: user)
    retweet.try(:destroy)
  end

end
