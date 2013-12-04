Switchboard::Application.routes.draw do
  resources :members, except: :show

  resources :messages, only: :create

  root to: 'members#index'
end
