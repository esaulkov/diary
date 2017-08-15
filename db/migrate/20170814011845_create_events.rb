# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start
      t.string :place
      t.text :description
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
