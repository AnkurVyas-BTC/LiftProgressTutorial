Rails.application.routes.draw do
  get 'tasks/get_stats' => 'tasks#get_stats'
  get 'tasks/get_tasks' => 'tasks#get_tasks'
  resources :tasks
  resources :users
  resources :lifts
  root to: 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
