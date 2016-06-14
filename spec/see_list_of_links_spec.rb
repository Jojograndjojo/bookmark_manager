require 'spec_helper'
require 'database_cleaner'

feature 'present a list of links on page' do
  scenario 'seeing links on the link page' do
    DatabaseCleaner.clean_with :truncation
    Link.create(title: 'Makers Academy' , url:'http://www.makersacademy.com')
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end
end
