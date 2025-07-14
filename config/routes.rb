Rails.application.routes.draw do
  resources :students
  root "students#index"

  # Health check (keep if you have it)
  get "up" => "rails/health#show", as: :rails_health_check
end
