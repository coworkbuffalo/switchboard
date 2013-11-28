Switchboard::Application.routes.draw do
  resources :members

  resources :messages, only: :create

  root to: 'members#index'
end
