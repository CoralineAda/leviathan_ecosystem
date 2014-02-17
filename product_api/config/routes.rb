ProductApi::Application.routes.draw do

  namespace :api do
    resources :widgets
  end

end
