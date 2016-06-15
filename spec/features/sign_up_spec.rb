feature 'Sign_up_users' do

  scenario 'sign up and new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'incorrect password confirmation' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Password and confirmation password do not match')
  end

  scenario 'blank email field' do
    expect{ sign_up(email: nil)}.not_to change(User, :count)
    expect(current_path).to eq('/users')
    # expect(page).to have_content('Please submit a valid email address')
  end

  scenario 'incorrect email format' do
    expect{ sign_up(email: 'dave@stuff')}.not_to change(User, :count)
    expect(current_path).to eq('/users')
    # expect(page).to have_content('Please submit a valid email address')
  end


end
