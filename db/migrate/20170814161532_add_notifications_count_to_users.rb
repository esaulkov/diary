# frozen_string_literal: true

class AddNotificationsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :notifications_count, :integer, default: 0, null: false
  end
end
