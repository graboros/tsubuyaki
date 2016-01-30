class Tweet < ActiveRecord::Base
  belongs_to :user
  counter_culture :user
  has_many :likes, dependent: :destroy

  belongs_to :retweet, class_name: 'Tweet'
  has_many :retweeteds, class_name: 'Tweet', foreign_key: 'retweet_id', dependent: :destroy
  validates :content, presence: { unless: :retweet? }

  def retweet?
    retweet.present?
  end

  validates :user, presence: true
  validates :content, length: { maximum: 140 }

  def unretweet(user)
    self.retweeteds.find_by(user: user).try(:destroy)
  end

end
