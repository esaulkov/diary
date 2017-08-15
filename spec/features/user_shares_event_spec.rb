require 'rails_helper'

feature 'user shares an event', js: true do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before do
    create_event_for(user1)
    login(user1.email, 'test-password')
  end

  scenario 'with valid data', driver: :webkit do
    expect(page).to have_content('The party')

    click_link 'Share'
    fill_in 'Email', with: user2.email
    click_button 'Share'

    expect(page).to have_content('Event was shared successfully')
    user2.reload
    expect(user2.notifications_count).to eq(1)
  end

  context 'when something wrong' do
    scenario 'user does not exist', driver: :webkit do
      click_link 'Share'
      fill_in 'Email', with: 'somebody@mail.me'
      click_button 'Share'

      expect(page).to_not have_content('Event was shared successfully')
      expect(page).to have_content('User with this email does not found')
    end

    scenario 'event was shared to this user before', driver: :webkit do
      user2.calendar.events << user1.events.first

      click_link 'Share'
      fill_in 'Email', with: user2.email
      click_button 'Share'

      expect(page).to_not have_content('Event was shared successfully')
      expect(page).to have_content('You shared event to this user before')
    end
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
end
