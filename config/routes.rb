Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
  get 'users/sign_out' => 'devise/sessions#destroy'
  end


  root 'home#index'
  resources :promotions do
    post 'generate_coupons', on: :member
  end

  resources :product_categories
  resources :coupons, only: %i[index] do
    post 'inactivate', on: :member
    post 'activate', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :coupons, param: :code, only: %i[show] do
        post 'burn', on: :member
      end
    end 
  end
end
