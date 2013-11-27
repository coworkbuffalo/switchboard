Switchboard::Application.routes.draw do
  resources :messages, only: :create
end
