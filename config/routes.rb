Tasklist::Application.routes.draw do
  resources :lists, :only => [:index, :create, :destroy] do
    resources :tasks, :only => [:create, :destroy] do
      member do
        put :complete
      end
    end
  end
  
  root :to => 'lists#index'
end
