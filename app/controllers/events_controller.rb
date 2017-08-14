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

  def update_calendar(user, event)
    user.calendar.events << event
  end
end
