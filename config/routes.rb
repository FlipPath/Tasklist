Tasklist::Application.routes.draw do
  root :to => 'lists#index', :constraints => lambda {|r| r.env["warden"].authenticate? }
  root :to => 'home#index'
  
  get "/" => 'lists#index', :as => "user_root"
  post "/pusher/auth" => 'pusher#auth', :format => :js
  
  devise_for :users
  resources :users, :only => :show do
    collection do
      get :search
    end
  end
  
  resources :lists, :only => [:index, :create, :destroy] do
    member do
      put :share, :update
      get :index
    end
    
    resources :tasks, :only => [:create, :destroy] do
      member do
        put :toggle_close, :insert_at, :update
      end
    end
  end
end
