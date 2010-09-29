Tasklist::Application.routes.draw do
  root :to => 'home#index'
  
  devise_for :users
  resources :users, :only => :show
  namespace :user do
    root :to => redirect('/lists')
  end

  resources :lists, :only => [:index, :create, :destroy] do
    resources :tasks, :only => [:create, :destroy] do
      member do
        put :toggle_complete
      end
    end
  end
end
