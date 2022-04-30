Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "static#dashboard"
  get 'people/:id', to: 'static#person'
  post 'user_expense', to: 'user_expense#create'
  post 'settle_up_expense', to: 'settle_up_expense#create'
  resources :users
  resources :user_expenses
  resources :settle_up_expenses
  resources :shared_expenses_between_users 
end
