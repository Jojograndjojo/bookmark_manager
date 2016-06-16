feature 'Sign_up_users' do

  scenario 'sign up and new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'incorrect password confirmation' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Password does not match the confirmation')
  end

  scenario 'user can\'t sign up with blank email field' do
    expect{ sign_up(email: nil)}.not_to change(User, :count)
    expect(current_path).to eq('/users')
    # expect(page).to have_content('Please submit a valid email address')
  end

  scenario 'user can\'t sign up with incorrect email format' do
    expect{ sign_up(email: 'dave@stuff')}.not_to change(User, :count)
    expect(current_path).to eq('/users')
    # expect(page).to have_content('Please submit a valid email address')
  end

  scenario 'user can not sign up using already registered email address' do
    sign_up
    expect{ sign_up }.not_to change(User, :count)
    expect(page).to have_content('Email is already taken')
  end

  scenario 'user can sign in and welcome message displayed' do
    email = 'alice2@example.com'
    sign_up(email: email)  
    sign_up(password: '12345678xx',
            password_confirmation: '12345678xx')
    sign_in(email: email)
    expect(page).to have_content("Welcome, #{email}")
  end

  scenario 'user can\'t sign in if email not registered' do
    sign_in
    expect(page).to have_content("There was a problem.")
  end

  scenario 'user can not sign in with wrong password' do
    email = 'alice2@example.com'
    sign_up(email: email,
            password: '12345678xx',
            password_confirmation: '12345678xx')
    sign_up
    sign_in(email: email, password: 'xxxxx')
    expect(page).to_not have_content("Welcome, #{email}")
  end

end
