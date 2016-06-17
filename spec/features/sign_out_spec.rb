feature 'signs user out' do
  scenario 'user can sign out of session' do
    sign_up
    sign_in
    click_button('Sign out')
    expect(page).to have_content('Goodbye, alice@example.com')
    expect(page).to_not have_content('Welcome, alice@example.com')
  end
end