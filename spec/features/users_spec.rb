require 'rails_helper'

RSpec.feature "Users", type: :feature do
  before do
    create(:user, last_name: 'Charles', email: 'foo@bar.com', age: 22, gender: 'male' )
    create(:user, last_name: 'Appleseed', email: 'sdsdd@bar.com', age: 22, gender: 'male' )
    create(:user, last_name: 'Stark', email: 'stark@bar.com', age: 35, gender: 'male' )
    create(:user, last_name: 'Romanoff', email: 'romanoff@bar.com', age: 40, gender: 'female' )
  end

  scenario "User can see all users", :aggregate_failures do
    visit users_path
    expect(page).to have_content 'Charles'
    expect(page).to have_content 'Appleseed'
    expect(page).to have_content 'Stark'
    expect(page).to have_content 'Romanoff'
  end

  context 'Filters' do
    scenario "User can see all users with age 22", :aggregate_failures do
      visit users_path
      select '22', from: 'Age'
      click_button 'Search'
      expect(page).to have_content 'Charles'
      expect(page).to have_content 'Appleseed'
      expect(page).not_to have_content 'Stark'
      expect(page).not_to have_content 'Romanoff'
    end

    scenario "Users can see all users female", :aggregate_failures do
      visit users_path
      select 'Female', from: 'Gender'
      click_button 'Search'

      expect(page).not_to have_content 'Charles'
      expect(page).not_to have_content 'Appleseed'
      expect(page).not_to have_content 'Stark'
      expect(page).to have_content 'Romanoff'
    end

    scenario "Users can find by email", :aggregate_failures do
      visit users_path

      fill_in 'Email', with: 'foo@bar.com'
      click_button 'Search'

      expect(page).to have_content 'Charles'
      expect(page).not_to have_content 'Appleseed'
      expect(page).not_to have_content 'Stark'
      expect(page).not_to have_content 'Romanoff'
    end

    scenario "Users can find by last name", :aggregate_failures do
      visit users_path

      fill_in 'Last name', with: 'Stark'
      click_button 'Search'

      expect(page).not_to have_content 'Charles'
      expect(page).not_to have_content 'Appleseed'
      expect(page).to have_content 'Stark'
      expect(page).not_to have_content 'Romanoff'
    end
  end

  context "Deleting users" do
    scenario "User can delete a user", :aggregate_failures, js: true do
      visit users_path

      expect(page).to have_content 'Charles'
      expect(page).to have_content 'Appleseed'
      expect(page).to have_content 'Stark'
      expect(page).to have_content 'Romanoff'

      check 'user_ids[]', match: :first

      page.find("[data-test-selector='delete_all_button']").click

      expect(page).not_to have_content 'Charles'
      expect(page).to have_content 'Appleseed'
      expect(page).to have_content 'Stark'
      expect(page).to have_content 'Romanoff'
    end
  end
end
