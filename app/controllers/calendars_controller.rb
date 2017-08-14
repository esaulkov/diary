# coding: utf-8
# frozen_string_literal: true

class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def remove_event
    event = Event.find(params[:id])
    if current_user.calendar.events.delete(event)
      redirect_to calendar_path, notice: t('notices.calendar.remove_event')
    else
      redirect_to calendar_path
    end
  end

  def show
    @events = current_user.calendar.events.starting_after(1.day.ago).order(:start).includes(:user)
  end
end
