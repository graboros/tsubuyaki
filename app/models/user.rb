class User < ActiveRecord::Base
  has_one :profile

  has_many :tweets, ->{order("created_at DESC")}

  has_many :to_messages, ->{order("created_at DESC")}, class_name: "Message", foreign_key: "sendto_id"

  has_many :likes
  has_many :like_tweets, ->{order("likes.created_at DESC")}, through: :likes
  has_many :retweeteds, through: :tweets

  has_many :followed_relationships, class_name: "Following", foreign_key: "followed_id"
  has_many :followers, through: :followed_relationships, source: :following
  has_many :following_relationships, class_name: "Following", foreign_key: "following_id"
  has_many :followings, through: :following_relationships, source: :follower
  validates :username, uniqueness: { case_sensitive: false }, length: { minimum: 3 }, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]
  attr_accessor :login

  def timeline_tweets
    timeline_users = self.followings.to_a << self
    Tweet.includes(:retweeteds).where(user: timeline_users).where(retweetings: {id: nil}).order(updated_at: :desc)
  end

  def liked?(tweet)
    self.like_tweets.include?(tweet)
  end
  def own?(tweet)
    self.tweets.include?(tweet)
  end
  def retweeting?(tweet)
    self.retweeteds.include?(tweet)
  end
  def following?(user)
    self.followings.include?(user)
  end

  def hasMessagesFrom
    self.to_messages.select(:user_id).uniq.map{|message| message.user}
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end
end
