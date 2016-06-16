
feature 'adding a tags' do

  scenario 'User can add a tag to a link' do
    visit('/links/new')
    fill_in :url, with: 'www.makersacademy.com'
    fill_in :title, with: 'MA'
    fill_in :tags, with: 'education'
    click_button 'Add Link'

    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
  end

  scenario 'User can add multiple tags to a link' do
    visit('/links/new')
    fill_in :url, with: 'www.makersacademy.com'
    fill_in :title, with: 'MA'
    fill_in :tags, with: 'education ruby'
    click_button 'Add Link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end
end
