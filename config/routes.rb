Tasklist::Application.routes.draw do
  resources :tasks, :only => [:index, :create]
  root :to => 'tasks#index'
end
