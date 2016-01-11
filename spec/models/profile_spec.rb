require 'rails_helper'

RSpec.describe Profile, :type => :model do
  before do
    @user = create(:user1)
  end

  it "is valid with user" do
    profile = build(:profile, user: @user)
    expect(profile).to be_valid
  end

  it "is invalid without user" do
    profile = build(:profile, user: nil)
    expect(profile).not_to be_valid
  end

  it "is invalid with 60 characters introduction" do
    profile = build(:large_profile, user: @user)
    expect(profile).to be_valid
  end

  it "is invalid with 61 characters introduction" do
    profile = build(:too_large_profile)
    expect(profile).not_to be_valid
  end

  it "is invalid with duplicate user profile" do
    create(:profile, user: @user)
    profile = build(:profile, user: @user)
    expect(profile).not_to be_valid
  end

  describe "update_with_params" do
    it "returns true with valid params" do
      profile = create(:profile, user: @user)
      result = profile.update_with_params(build(:profile, user: @user));
      expect(result).to be_truthy
    end

    it "returns false with invalid params" do
      profile = create(:profile, user: @user)
      result = profile.update_with_params(build(:too_large_profile, user: @user));
      expect(result).to be_falsey
    end

    it "changes introduction param" do
      profile = create(:profile2, user: @user)
      result = profile.update_with_params(build(:profile, user: @user));
      expect(@user.profile.introduction).not_to eq build(:profile2)[:introduction]
    end

    it "does not change image with no image param" do
      profile = create(:profile, user: @user)
      result = profile.update_with_params(build(:profile_without_image, user: @user));
      expect(@user.profile).not_to be_nil
    end

    it "changes image with image param" do
      profile = create(:profile, user: @user)
      result = profile.update_with_params(build(:profile_with_image, user: @user));
      expect(@user.profile.image).not_to eq build(:profile_with_image)[:image]
    end
  end

end
