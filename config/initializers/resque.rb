# frozen_string_literal: true

require 'resque'

Resque.redis = Redis.new(url: ENV['REDIS_URL'])
Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}_resque.log"))
