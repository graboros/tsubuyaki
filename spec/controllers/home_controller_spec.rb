require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  describe "GET #index" do

    context "when signed-in" do
      login_user

      before do
        @tweet1 = create(:tweet1, user: subject.current_user)
        @tweet2 = create(:long_tweet, user: subject.current_user)
      end

      it "populates an array of the current_user's timeline tweets" do
        get :index
        expect(assigns(:timeline_tweets)).to match_array([@tweet1, @tweet2])
      end

      it "renders the :timeline template" do
        get :index
        expect(response).to render_template :timeline
      end
    end

    context "when not signed-in" do

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

  end

  describe "POST #search" do

    context "with a empty text" do
      it "redirects to root url" do
        post :search, home: { text: "" }
        expect(response).to redirect_to root_url
      end
    end

    context "with a some characters text" do
      it "assigns the posted text to @text" do
        get :search, home: { text: "search condition" }
        expect(assigns(:text)).to eq "search condition"
      end

      it "renders the :search template" do
        post :search, home: { text: "search condition" }
        expect(response).to render_template :search
      end
    end
  end
end
