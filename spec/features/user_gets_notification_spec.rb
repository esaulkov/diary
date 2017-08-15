require 'rails_helper'

feature 'user gets notification' do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before do
    create_event_for(user1)
    share_event(user1, user2)
    login(user2.email, 'test-password')
  end

  scenario 'read notification' do
    expect(page).to have_link('1', href: '/notification')
    click_link '1'

    expect(current_path).to start_with('/events/')
    expect(page).to have_content('The party')
    expect(page).to_not have_link(nil, href: '/notification')
  end

  private

  def create_event_for(user)
    event = user.events.create(
      name: 'The party',
      start: 1.week.from_now,
      place: 'Las-Vegas',
      description: 'The last party in the world!'
    )
    user.calendar.events << event
  end

  def login(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  def share_event(user1, user2)
    event = user1.events.last
    user2.calendar.events << event
    user2.notifications.create(event_id: event.id)
  end
end
