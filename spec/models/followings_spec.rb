require 'rails_helper'

RSpec.describe Following, :type => :model do
  before :each do 
    @user1 = create(:user1)
    @user2 = create(:user2)
  end

  it "is valid with a following and a follower" do
    following = build(:following, following: @user1, follower: @user2)
    expect(following).to be_valid
  end

  it "is invalid without a following" do
    following = build(:following, following: nil, follower: @user2)
    expect(following).not_to be_valid
  end

  it "is invalid without a follower" do
    following = build(:following, following: @user1, follower: nil)
    expect(following).not_to be_valid
  end

  it "is invalid with a duplicate following" do
    create(:following, following: @user1, follower: @user2)
    following = build(:following, following: @user1, follower: @user2)
    expect(following).not_to be_valid
  end

end
