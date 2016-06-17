feature 'Reset password' do
  scenario 'User can reset a password' do
    visit '/users/sign_in'
    click_button 'Reset Password'
    fill_in :email, with: 'alice@example.com'
    click_button 'Submit'
    expect(page).to have_content 'Please check your e-mail'
  end
end