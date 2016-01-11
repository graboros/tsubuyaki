require 'rails_helper'

RSpec.describe Retweeting, :type => :model do
  before :each do 
    @user1 = create(:user1)
    @user2 = create(:user2)
    @tweet1 = create(:tweet, user: @user1, content: nil)
    @tweet2 = create(:tweet, user: @user2)
    @tweet3 = create(:tweet, user: @user2)
  end

  it "is valid with a retweet and a retweeted " do
    retweeting = build(:retweeting, retweet: @tweet1, retweeted: @tweet2)
    expect(retweeting).to be_valid
  end

  it "is invalid without any retweet" do
    retweeting = build(:retweeting, retweet: @tweet1, retweeted: nil)
    expect(retweeting).not_to be_valid
  end


  it "is invalid with a duplicate retweeting" do
    create(:retweeting, retweet: @tweet1, retweeted: @tweet2)
    retweeting = build(:retweeting, retweet: @tweet1, retweeted: @tweet2)
    expect(retweeting).not_to be_valid
  end

end
