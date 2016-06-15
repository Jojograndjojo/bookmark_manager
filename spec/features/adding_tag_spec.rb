feature 'addding tags' do
  scenario 'user can add a tag' do
    visit('/links/new')
    fill_in('url', with: 'www.merve.com')
    fill_in('title', with: 'Magic Merve')
    fill_in('tags', with: 'Magical')
    click_button('Submit')
    link = Link.first
    expect(link.tags.map(&:name)).to include('Magical')
  end
end