require 'rails_helper'

feature "Comunication" do

  let(:user) { create(:user1) }

  scenario "add tweet", js: true do

    as_user(user) do

      visit root_path

      fill_in 'tweet_content', with: '新規つぶやき'
      click_button 'ツイート'

      expect(page).to have_content 'ツイートしました'
    end
  end

end
