Rails.application.routes.draw do
  resources :quote_templates
  root 'people#index'
  resources :people
  resources :quotes
end
