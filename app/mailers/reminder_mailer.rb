# coding: utf-8
# frozen_string_literal: true

class ReminderMailer < ApplicationMailer
  include Resque::Mailer

  def reminder_email(event_id)
    @event = Event.find(event_id)
    @event.calendars.each do |calendar|
      mail(to: calendar.user.email, subject: t('.subject'))
    end
  end
end
