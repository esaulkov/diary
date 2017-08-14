require 'rails_helper'

feature 'User destroys or removes an event' do
  let(:user) { create(:user) }
  let(:user2) { create(:user, email: 'another@mail.me', password: 'abracadabra') }

  before do
    create_user_and_login
  end

  scenario 'user destroys an event' do
    event = create_event_for(user)
    user.calendar.events << event

    visit calendar_path
    expect(page).to have_content('The party')

    click_link 'Delete'

    expect(current_path).to eq('/calendar')
    expect(page).to_not have_content('The party')
    expect(page).to have_content('Event was deleted successfully')
  end

  scenario 'user removes an event from calendar' do
    event = create_event_for(user2)
    user.calendar.events << event

    visit calendar_path
    expect(page).to have_content('The party')

    click_link 'Remove'

    expect(current_path).to eq('/calendar')
    expect(page).to_not have_content('The party')
    expect(page).to have_content('Event was successfully removed from your calendar')
  end

  scenario "user couldn't destroy other's event" do
    event = create_event_for(user2)
    user.calendar.events << event

    visit calendar_path
    expect(page).to have_content('The party')
    expect(page).to_not have_content('Delete')
  end

  private

  def create_event_for(user)
    user.events.create(
      name: 'The party',
      start: 1.week.from_now,
      place: 'Las-Vegas',
      description: 'The last party in the world!'
    )
  end

  def create_user_and_login
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'test-password'
    click_button 'Log in'
  end
end
