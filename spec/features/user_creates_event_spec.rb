require 'rails_helper'

feature 'User creates an event' do
  let(:user) { create(:user) }

  before do
    create_user_and_login
    click_link 'New event'
  end

  scenario 'with valid data' do
    expect(current_path).to eq('/events/new')
    expect(page).to have_content('New event')

    fill_form_and_save(
      name: 'The coolest party',
      start: 3.days.from_now,
      place: 'Somewhere',
      description: 'Test description'
    )

    expect(current_path).to eq('/calendar')
    expect(page).to have_content('Event was created successfully')
  end

  context 'with invalid data' do
    scenario 'when event name is missed' do
      fill_form_and_save(
        start: 3.days.from_now,
        place: 'Somewhere',
        description: 'Test description'
      )

      expect(current_path).to eq('/events')
      expect(page).to have_content("Namecan't be blank")
    end

    scenario 'when event place is missed' do
      fill_form_and_save(
        name: 'The coolest party',
        start: 3.days.from_now,
        description: 'Test description'
      )

      expect(current_path).to eq('/events')
      expect(page).to have_content("Placecan't be blank")
    end

    scenario 'when event date is in past' do
      fill_form_and_save(
        name: 'The coolest party',
        start: 3.days.ago,
        place: 'Somewhere',
        description: 'Test description'
      )

      expect(current_path).to eq('/events')
      expect(page).to have_content('should be in the future')
    end
  end

  private

  def create_user_and_login
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'test-password'
    click_button 'Log in'
  end

  def fill_form_and_save(data)
    fill_in 'Name', with: data[:name]
    select_date_and_time(data[:start], from: 'event_start')
    fill_in 'Place', with: data[:place]
    fill_in 'Description', with: data[:description]
    click_button 'Save'
  end

  def select_date_and_time(date, options = {})
    field = options[:from]
    select date.strftime('%Y'), from: "#{field}_1i"
    select date.strftime('%B'), from: "#{field}_2i"
    select date.strftime('%d'), from: "#{field}_3i"
    select date.strftime('%H'), from: "#{field}_4i"
    select date.strftime('%M'), from: "#{field}_5i"
  end
end
