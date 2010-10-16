Rr10Team71::Application.routes.draw do
  resources :comments

  devise_for :users
  
  resources :events do 
    resources :proposals do
      member do
        get :like
        get :dislike  
      end  
    end
  end

  root :to => "events#index"

  

end
