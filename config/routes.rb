require 'sidekiq/web'

Twilio::Application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  resources :reminders, only: [:create] 
end
