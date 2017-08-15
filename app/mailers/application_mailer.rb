# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'reminder@example.com'
  layout 'mailer'
end
