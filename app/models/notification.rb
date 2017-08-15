# coding: utf-8
# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :event
end
