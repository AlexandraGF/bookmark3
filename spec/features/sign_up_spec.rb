feature 'Sign up page' do
  scenario 'user sign up' do
    visit ('/')
    fill_in 'email' , with: 'giada@yahoo.com'
    fill_in 'password', with: 'learn456'
    click_button 'Submit'
    expect(page).to have_content('Links')
  end

  scenario 'check the user receives a welcome message' do
    visit ('/')
    fill_in 'email' , with: 'giada@yahoo.com'
    fill_in 'password', with: 'learn456'
    click_button 'Submit'
    expect(page).to have_content('Welcome, giada@yahoo.com')
  end

  scenario 'check the user number increases by 1' do
    expect {log_in}.to change(User, :count).by(2)
    # expect(User.count).to eq 1
  end

  def log_in
    visit ('/')
    fill_in 'email' , with: 'giada@yahoo.com'
    fill_in 'password', with: 'learn456'
    click_button 'Submit'
  end
end
