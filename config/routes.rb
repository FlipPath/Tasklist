Tasklist::Application.routes.draw do
  root :to => 'lists#index', :constraints => lambda {|r| r.env["warden"].authenticate? }
  root :to => 'home#index'
  
  devise_for :users
  resources :users, :only => :show do
    collection do
      get :search
    end
  end
  
  get "/lists" => 'lists#index', :as => "user_root"
  
  resources :lists, :only => [:index, :create, :destroy] do
    member do
      put :reorder, :share
    end
    
    resources :tasks, :only => [:create, :destroy] do
      member do
        put :toggle_complete
      end
    end
  end
end
