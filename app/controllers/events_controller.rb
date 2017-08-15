# coding: utf-8
# frozen_string_literal: true

class EventsController < ApplicationController
  def new
    @event = current_user.events.new
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
      update_calendar(current_user, @event)
      redirect_to calendar_path, notice: t('notices.event.created')
    else
      render :new
    end
  end

  def share
    event = Event.find(share_params[:id])
    user = User.find_by_email(share_params[:email])

    if user.nil?
      message = {alert: t('alerts.event.email_not_found')}
    elsif user.calendar.events.include?(event)
      message = {alert: t('alerts.event.double_shared')}
    else
      user.calendar.events << event
      user.notifications.create(event_id: event.id)
      message = {notice: t('notices.event.shared')}
    end

    redirect_to calendar_path, message
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to calendar_path, notice: t('notices.event.updated')
    else
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to calendar_path, notice: t('notices.event.deleted')
  end

  private

  def event_params
    params.require(:event).permit(:name, :start, :place, :description)
  end

  def share_params
    params.require(:event).permit(:id, :email)
  end

  def update_calendar(user, event)
    user.calendar.events << event
  end
end
