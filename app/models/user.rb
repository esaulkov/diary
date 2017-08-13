# coding: utf-8
# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :calendar

  after_create :add_calendar

  private

  def add_calendar
    create_calendar
  end
end
