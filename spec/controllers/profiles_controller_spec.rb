require 'rails_helper'

RSpec.describe ProfilesController, :type => :controller do

  describe "patch #update" do
    login_user

    context "with invalid attributes" do
      it "changes the current_user's profile attributes" do
        patch :update, user_id: subject.current_user, profile: attributes_for(:profile2)
        expect(subject.current_user.profile.introduction).to eq build(:profile2).introduction
      end
    end

    it "redirects to the profile#edit " do
      patch :update, user_id: subject.current_user, profile: attributes_for(:profile2)
      expect(response).to redirect_to edit_user_profile_url(subject.current_user)
    end
  end

  describe "GET #edit" do
    login_user

    it "renders the :edit template" do
      get :edit, user_id: subject.current_user
      expect(response).to render_template :edit
    end

  end
end
