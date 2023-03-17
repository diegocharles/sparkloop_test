Rails.application.routes.draw do
  resources :users do
    delete :bulk_destroy, on: :collection
    get :bulk_import, on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
end
