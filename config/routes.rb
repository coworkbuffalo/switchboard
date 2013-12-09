Switchboard::Application.routes.draw do
  resources :members, except: :show

  resources :messages, only: [:index]

  resources :entries, only: [:create, :index]

  get "wemo", to: "wemo#show"

  root to: 'entries#index'
end
