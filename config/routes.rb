Rails.application.routes.draw do
  root 'people#index'
  resources :people
  resources :quotes
end
