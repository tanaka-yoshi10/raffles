Rails.application.routes.draw do
  get 'users/new'

  resources :tasks do
    collection do
      post :import
    end
  end
  resources :projects

  root 'tasks#index'
end
