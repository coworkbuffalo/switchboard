Switchboard::Application.routes.draw do
  resources :members, except: :show

  resources :messages, only: [:create, :index]

  root to: 'members#index'
end
