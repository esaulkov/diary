# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :users, only: %i[registrations sessions unlocks passwords]

  get '/calendar', to: 'calendars#show', as: 'calendar'
  delete '/delete_event/:id', to: 'calendars#remove_event', as: 'delete_event'

  resources :events, except: [:index]
  post '/events/share', to: 'events#share', as: 'share_event'

  get '/notification', to: 'notifications#decrease', as: 'notificaton'
end
