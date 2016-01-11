require 'rails_helper'

feature "Tweet Search" do
  background {
    user2 = create(:user2)
    create(:tweet1, user: user2, content: "てすとツイート")
  }

  let(:user) { create(:user1) }

  scenario "shows tweets with registered tweet content when signed-in" do

    as_user(user) do

      visit root_path

      fill_in 'home_text', with: 'てすとツイート'
      click_button '検索'
      expect(page).not_to have_content '該当のツイートは存在しません'
      expect(current_path).to eq search_path
    end
  end

  scenario "shows nothing with not registered tweet content when signed-in" do

    as_user(user) do

      visit root_path

      fill_in 'home_text', with: '未登録ツイート'
      click_button '検索'
      expect(page).to have_content '該当のツイートは存在しません'
      expect(current_path).to eq search_path

    end
  end

  scenario "shows tweets with registered tweet content when not signed-in" do

    visit root_path

    fill_in 'home_text', with: 'てすとツイート'
    click_button '検索'
    expect(page).not_to have_content '該当のツイートは存在しません'
    expect(current_path).to eq search_path
  end

  scenario "shows nothing with not registered tweet content when not signed-in" do
    visit root_path

    fill_in 'home_text', with: '未登録ツイート'
    click_button '検索'
    expect(page).to have_content '該当のツイートは存在しません'
    expect(current_path).to eq search_path
  end
end
