Rails.application.routes.draw do
  resources :users, only: %i[create index show update]
  resources :chats, only: %i[create index] do
    resources :messages, only: %i[index create update show]
  end
end
