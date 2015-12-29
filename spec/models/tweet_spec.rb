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

end
