require 'rails_helper'

RSpec.describe Like, :type => :model do
  before :each do 
    @user1 = create(:user1)
    @user2 = create(:user2)
    @tweet2 = create(:tweet, user: @user2)
  end

  it "is valid with a tweet and a user" do
    like = build(:like, user: @user1, like_tweet: @tweet2)
    expect(like).to be_valid
  end

  it "is invalid without any tweet" do
    like = build(:like, user: @user1, like_tweet: nil)
    expect(like).not_to be_valid
  end

  it "is invalid without any user" do
    like = build(:like, user: nil, like_tweet: @tweet2)
    expect(like).not_to be_valid
  end

  it "is invalid with a duplicate like" do
    create(:like, user: @user1, like_tweet: @tweet2)
    like = build(:like, user: @user1, like_tweet: @tweet2)
    expect(like).not_to be_valid
  end

end
