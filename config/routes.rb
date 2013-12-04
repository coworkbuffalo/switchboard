Switchboard::Application.routes.draw do
  resources :members, except: :show

  resources :messages, only: [:create, :index]

  get "wemo", to: "wemo#show"

  root to: 'members#index'
end
