BillingWalrus::Application.routes.draw do

  devise_for :users

  resources :bills, :services, :vendors
  post 'bills/:id/mail' => 'bills#mail', :as => 'bill_mail'

  scope :path => 'admin' do
    resources :users
  end

  scope :path => 'bills/:bill_id' do
    resources :slices do
      resources :payments
    end
    #post 'slices' => 'slices#new', :as => 'new_slice'
    #put 'slices/:id' => 'slices#update', :as => 'slice'
    #get 'slices' => 'slices#index', :as => 'slices'
    #get 'slices/new' => 'slices#new', :as => 'new_slice'
  end

  root :to => "users#dashboard"
end
