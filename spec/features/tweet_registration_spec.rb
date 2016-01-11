require 'rails_helper'

feature "Tweet Registration" do

  let(:user) { create(:user1) }

  scenario "goes well with nomal length tweet", js: true do

    as_user(user) do

      visit root_path

      expect {
        fill_in 'tweet_content', with: Faker::Lorem.characters(140)
        click_button 'ツイート'
      }.to change(Tweet, :count).by(1)
      expect(page).to have_content 'ツイートしました'
      expect(current_path).to eq root_path

    end
  end

  scenario "goes wrong with long tweet", js: true do

    as_user(user) do

      visit root_path

      fill_in 'tweet_content', with: Faker::Lorem.characters(141)
      expect(page).to have_content '-1'
      expect {
        click_button 'ツイート'
      }.not_to change(Tweet, :count)
      expect(page).to have_content 'ツイートに失敗しました'
      expect(current_path).to eq root_path

    end
  end
end
