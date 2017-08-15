require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  describe '.reminder_email' do
    let(:event) { create(:event) }

    before { event.calendars << event.user.calendar }

    subject { mail = ReminderMailer.reminder_email(event.id) }

    it 'has expected subject' do
      is_expected.to have_subject('Your event will start soon')
    end

    it { is_expected.to be_delivered_from('reminder@example.com') }

    it { is_expected.to be_delivered_to(event.user) }
  end
end
