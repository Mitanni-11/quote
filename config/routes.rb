Rails.application.routes.draw do
  devise_for :users, controllers: { :registrations => 'users/registrations',
                                    :sessions => 'users/sessions' ,
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
    get 'profile/:id/' => 'users/registrations#profile', as: 'profile'
    get 'profile/:id/following', to: 'users/registrations#following', as: 'following'
    get 'profile/:id/followers', to: 'users/registrations#followers', as: 'followers'
  end

  resources :relationships, only: [:create, :destroy]

  root 'rhetorics#index'

  resources :rhetorics do
    member do
      get :image
    end
    resources :comments
  end

  get 'search', to: 'rhetorics#search'

  get 'comments/create'
  get 'comments/destroy'

  post "picks/:rhetoric_id/create" => "picks#create"
  post "picks/:rhetoric_id/destroy" => "picks#destroy"
end

