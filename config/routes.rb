Rr10Team71::Application.routes.draw do
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure'

  devise_for :users

  resources :comments
  resource :profile

  resources :events do
    member do
      get :crop
    end

    resources :proposals do
      member do
        get :like
        get :dislike
      end
    end
  end

  root :to => "home#index"

end
