require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  describe "GET #index" do

    context "with the user signed-in" do
      login_user

      before do
        @tweet1 = create(:tweet1, user: subject.current_user)
        @tweet2 = create(:long_tweet, user: subject.current_user)
      end

      it "populates an array of current_user's timeline tweets" do
        get :index
        expect(assigns(:timeline_tweets)).to match_array([@tweet1, @tweet2])
      end
      it "render :timeline template" do
        get :index
        expect(response).to render_template :timeline
      end
    end

    context "without the user signed-in" do

      it "render :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

  end

  describe "GET #search" do

    context "with empty text" do
      it "redirect to root url" do
        post :search, home: { text: "" }
        expect(response).to redirect_to root_url
      end
    end

    context "with some characters text" do
      it "assigns the posted text to @text" do
        get :search, home: { text: "search condition" }
        expect(assigns(:text)).to eq "search condition"
      end
      it "render :search template" do
        post :search, home: { text: "search condition" }
        expect(response).to render_template :search
      end
    end
  end
end
