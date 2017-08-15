# coding: utf-8
# frozen_string_literal: true

class NotificationsController < ApplicationController
  def decrease
    notification = current_user.notifications.last
    event = notification.event
    notification.destroy
    redirect_to event
  end
end
