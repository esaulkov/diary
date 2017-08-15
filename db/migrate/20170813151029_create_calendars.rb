# frozen_string_literal: true

class CreateCalendars < ActiveRecord::Migration[5.1]
  def change
    create_table :calendars do |t|
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
