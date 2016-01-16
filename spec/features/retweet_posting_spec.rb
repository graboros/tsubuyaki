require 'rails_helper'

feature "Retweet Posting" do
  let(:user) { create(:user1) }

  background {
    @user2 = create(:user2)
    @tweet2 = create(:tweet1, user: @user2, content: "てすとツイート1")

    @user3 = create(:user3)
    @tweet3 = tweet = create(:tweet1, user: @user3, content: "てすとツイート2")

    create(:following, following: @user2, follower: user) 

    @tweet1 = create(:tweet1, user: user, content: "nil")
    create(:retweeting, retweet: @tweet1, retweeted: @tweet3)

  }

  scenario "done on timeline", js: true do

    as_user(user) do

      visit root_path

      click_link 'リツイート'

      expect(current_path).to eq root_path
      expect(page).to have_selector 'a.btn-info', text: 'リツイート'
    end
  end

  scenario "is cancelled on own user page", js: true do

    as_user(user) do

      visit user_path(user)

      click_link 'リツイート'

      expect(current_path).to eq user_path(user)
      expect(page).not_to have_selector 'a.btn-info', text: 'リツイート'
    end
  end
end
