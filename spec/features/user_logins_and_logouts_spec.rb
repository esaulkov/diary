require 'rails_helper'

feature 'User logs in and logs out' do
  let(:user) { create(:user) }

  scenario 'with valid details' do

    visit '/'

    click_link 'Login'
    expect(page).to have_css('h2', text: 'Log in')
    expect(current_path).to eq(new_user_session_path)

    login(user.email, 'test-password')

    expect(current_path).to eq('/')
    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content(user.email)

    click_on 'Logout'

    expect(current_path).to eq('/')
    expect(page).to have_content('Signed out successfully')
    expect(page).not_to have_content(user.email)
  end

  context 'with invalid details' do
    before do
      visit new_user_session_path
    end

    scenario 'wrong email' do
      login(user.email[0...-1], 'test-password')

      expect(current_path).to eq('/users/sign_in')
      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'wrong password' do
      login(user.email, 'wrong-password')

      expect(current_path).to eq('/users/sign_in')
      expect(page).to have_content('Invalid Email or password')
    end
  end

  private

  def login(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end
end
