# coding: utf-8
# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :calendars

  validates :name, presence: true
  validates :place, presence: true
  validates :start, presence: true
  validate :date_in_future, on: :create

  scope :starting_after, ->(time) { where('start >= ?', time) }

  private

  def date_in_future
    errors.add(:start, 'should be in the future') if start < DateTime.current
  end
end
