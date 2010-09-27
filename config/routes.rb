Tasklist::Application.routes.draw do
  resources :tasks, :only => [:index, :create] do
    member do
      put :complete
    end
  end
  root :to => 'tasks#index'
end
