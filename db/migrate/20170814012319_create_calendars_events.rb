# frozen_string_literal: true

class CreateCalendarsEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :calendars_events, id: false do |t|
      t.belongs_to :calendar, index: true
      t.belongs_to :event, index: true
    end
  end
end
