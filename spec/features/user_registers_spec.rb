# frozen_string_literal: true

require 'rails_helper'

feature 'User registers' do
  scenario 'with valid details' do
    visit '/'

    click_link 'Login'
    click_link 'Sign up'
    expect(current_path).to eq(new_user_registration_path)

    fill_in 'Email', with: 'tester@mail.example'
    fill_in 'Password', with: 'test-password'
    fill_in 'Password confirmation', with: 'test-password'
    click_button 'Sign up'

    expect(current_path).to eq('/')
    expect(page).to have_content('You have signed up successfully.')
  end

  context 'with invalid details' do
    before do
      visit new_user_registration_path
    end

    scenario 'blank fields' do

      expect_fields_to_be_blank

      click_button 'Sign up'

      expect(current_path).to eq('/users')
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end

    scenario 'already registered email' do

      create(:user, email: 'tester@mail.example')

      fill_in 'Email', with: 'tester@mail.example'
      fill_in 'Password', with: 'test-password'
      fill_in 'Password confirmation', with: 'test-password'
      click_button 'Sign up'

      expect(page).to have_content('Email has already been taken')
    end

    scenario 'invalid email' do

      fill_in 'Email', with: 'invalid-email-for-testing'
      fill_in 'Password', with: 'test-password'
      fill_in 'Password confirmation', with: 'test-password'
      click_button 'Sign up'

      expect(page).to have_content('Email is invalid')
    end

    scenario 'too short password' do

      min_password_length = 6
      too_short_password = 'p' * (min_password_length - 1)
      fill_in 'Email', with: 'tester@mail.example'
      fill_in 'Password', with: too_short_password
      fill_in 'Password confirmation', with: too_short_password
      click_button 'Sign up'

      expect(page).to have_content('Password is too short (minimum is 6 characters)')
    end
  end

  private

  def expect_fields_to_be_blank
    expect(page).to have_field('Email', with: '', type: 'email')
    expect(find_field('Password', type: 'password').value).to be_nil
    expect(find_field('Password confirmation', type: 'password').value).to be_nil
  end
end