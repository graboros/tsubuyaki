require 'rails_helper'

RSpec.describe Tweet, :type => :model do

  before :each do 
    @user = create(:user1)
  end

  it "is valid with user, content" do
    tweet = build(:tweet1, user: @user)
    expect(tweet).to be_valid
  end

  it "is invalid without user" do
    tweet = build(:tweet1, user: nil)
    tweet.valid?
    expect(tweet.errors[:user]).to include("can't be blank")
  end

  it "is valid with 140 characters content" do
    tweet = build(:long_tweet, user: @user)
    tweet.valid?
    expect(tweet).to be_valid
  end

  it "is invalid with 141 characters content" do
    tweet = build(:too_long_tweet, user: @user)
    tweet.valid?
    expect(tweet.errors[:content]).to include("is too long (maximum is 140 characters)")
  end

  describe "unretweet" do
    before :each do 
      @user2 = create(:user2)
      @tweet1 = create(:tweet, user: @user, content: nil)
      @tweet2 = create(:tweet, user: @user2)
      @tweet3 = create(:tweet, user: @user2)
      create(:retweeting, retweet: @tweet1, retweeted: @tweet2)
    end

    it "deletes the retweeting in the database with retweeted tweet" do
      expect {
        @tweet2.unretweet(@user)
      }.to change(Retweeting, :count).by(-1)
    end

    it "does not delete the retweeting in the database with not retweeted tweet" do
      expect {
        @tweet3.unretweet(@user)
      }.not_to change(Retweeting, :count)
    end
  end

end
