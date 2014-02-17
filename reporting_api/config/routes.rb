ReportingApi::Application.routes.draw do

  namespace :api do
    resources :events, only: [:index]
    get 'total_customer_report' => 'reports#total_customers'
    get 'meta_report' => 'reports#meta'
  end

end
