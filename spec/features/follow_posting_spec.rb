require 'rails_helper'

feature "Follow Posting" do
  let(:user) { create(:user1) }

  background {
    @user2 = create(:user2)
    create(:tweet1, user: @user2, content: "てすとツイート")

    @user3 = create(:user3)
    create(:following, following: @user3, follower: user) 
  }


  scenario "done through tweets search", js: true do

    as_user(user) do

      visit root_path

      fill_in 'home_text', with: 'てすとツイート'
      click_button '検索'
      expect(current_path).to eq search_path

      click_link @user2.username

      expect(current_path).to eq user_path(@user2)

      find('.followbtn').click

      expect(page).to have_content 'フォロー中'
      expect(current_path).to eq user_path(@user2)
    end
  end

  scenario "is cancelled on own user page", js: true do

    as_user(user) do

      visit user_path(user)

      click_link 'フォロー'

      click_link 'フォロー中'

      expect(current_path).to eq user_followings_path(user)
      expect(page).not_to have_content 'フォロー中'
    end
  end
end
