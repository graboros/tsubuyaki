require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with username, password" do
    user = build(:user1, username: "takashi", password: "password")
    expect(user).to be_valid
  end

  it "is invalid without username" do
    user = build(:user1, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid without password" do
    user = build(:user1, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with 2 characters username" do
    user = build(:user1, username: "un")
    user.valid?
    expect(user.errors[:username]).to include("is too short (minimum is 3 characters)")
  end

  it "is valid with 3 characters username" do
    user = build(:user1, username: "unm")
    expect(user).to be_valid
  end

  it "is invalid with a duplicate username" do
    create(:user1, username: "takashi")
    user = build(:user2,  username: "takashi")
    user.valid?
    expect(user.errors[:username]).to include("has already been taken")
  end

  it "is invalid with a duplicate email" do
    create(:user1, email: "takashi2003_jp@yahoo.co.jp" )
    user = build(:user2, email: "takashi2003_jp@yahoo.co.jp")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  describe "timeline_tweets" do
    before :each do 
      @user1 = create(:user1)
      @tweet1 = create(:tweet, user: @user1)
      @tweet2 = create(:long_tweet, user: @user1)

      @user2 = create(:user2)
      @tweet3 = create(:tweet, user: @user2)

      @user1.followed_relationships.find_or_create_by!(following: @user2)
    end

    it "includes own tweets and followings tweets" do
      expect(@user1.timeline_tweets).to include(@tweet1, @tweet2, @tweet3)
    end

    it "does not include retweets" do
      @retweet = @user1.tweets.build()
      @retweet.retweeting_relationships.build(retweeted: @tweet3)
      @retweet.save

      expect(@user1.timeline_tweets).not_to include(@retweet)
    end
  end

  describe "own?" do
    before :each do 
      @user1 = create(:user1)
      @tweet1 = create(:tweet, user: @user1)

      @user2 = create(:user2)
      @tweet2 = create(:tweet, user: @user2)
    end

    it "returns true with own tweet" do
      expect(@user1.own?(@tweet1)).to be_truthy
    end

    it "returns false with others tweet" do
      expect(@user1.own?(@tweet2)).to be_falsey
    end

    it "returns false with nil" do
      expect(@user1.own?(@tweet2)).to be_falsey
    end
  end

  describe "liked?" do
    before :each do 
      @user1 = create(:user1)
      @user2 = create(:user2)
      @tweet2 = create(:tweet, user: @user2)
      create(:like, user: @user1, like_tweet: @tweet2)
    end

    it "returns true with liked tweet" do
      expect(@user1.liked?(@tweet2)).to be_truthy
    end

    it "returns false with not liked tweet" do
      expect(@user2.liked?(@tweet2)).to be_falsey
    end
  end

  describe "retweeting?" do
    before :each do 
      @user1 = create(:user1)
      @user2 = create(:user2)
      @tweet1 = create(:tweet, user: @user1, content: nil)
      @tweet2 = create(:tweet, user: @user2)
      @tweet3 = create(:tweet, user: @user2)
      create(:retweeting, retweet: @tweet1, retweeted: @tweet2)
    end

    it "returns true with retweeted tweet" do
      expect(@user1.retweeting?(@tweet2)).to be_truthy
    end

    it "returns false with not retweeted tweet" do
      expect(@user1.retweeting?(@tweet3)).to be_falsey
    end
  end

  describe "following?" do
    before :each do 
      @user1 = create(:user1)
      @user2 = create(:user2)
      create(:following, following: @user2, follower: @user1)
    end

    it "returns true with following user" do
      expect(@user1.following?(@user2)).to be_truthy
    end

    it "returns false with not following user" do
      expect(@user2.following?(@user1)).to be_falsey
    end
  end
end
