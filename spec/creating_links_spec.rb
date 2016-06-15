require 'spec_helper'

feature 'adding new links' do
  scenario 'adding one link' do
    visit('/links')
    click_link('Create New link')
    fill_in('title', with: 'Google')
    fill_in('url', with: 'http://www.google.com')
    click_button('Submit')
    expect(page).to have_content('Google')
  end
end