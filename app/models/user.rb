# coding: utf-8
# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :calendar, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :notifications, dependent: :destroy

  after_create :add_calendar

  private

  def add_calendar
    create_calendar
  end
end
