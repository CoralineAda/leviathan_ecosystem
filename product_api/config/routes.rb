ProductApi::Application.routes.draw do

  namespace :api do
    resources :customers
  end

end
