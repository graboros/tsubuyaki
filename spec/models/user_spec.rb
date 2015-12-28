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
end
