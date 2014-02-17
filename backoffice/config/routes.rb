Backoffice::Application.routes.draw do

  root "customers#index"
  resources :customers
  resources :widgets
    
end
