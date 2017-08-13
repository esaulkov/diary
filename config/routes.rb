# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :users, only: %i[registrations sessions unlocks passwords]

  get '/calendars/:id', to: 'calendars#show', as: 'calendar'
end
