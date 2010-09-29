Tasklist::Application.routes.draw do
  root :to => 'home#index'
  
  devise_for :users
  resources :users, :only => :show
  
  get "/lists" => 'lists#index', :as => "user_root"
  
  resources :lists, :only => [:index, :create, :destroy] do
    resources :tasks, :only => [:create, :destroy] do
      member do
        put :toggle_complete
      end
    end
  end
end
