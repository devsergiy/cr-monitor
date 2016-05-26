Rails.application.routes.draw do
  get  '/sign_in',  to: 'sessions#new'
  post '/sign_in',  to: 'sessions#create'
  get  '/sign_out', to: 'sessions#destroy'

  root 'instances#index'

  resources :instances, only: %w(index show), as: :agent_instances do
    member do
      get :shutdown
      get :start
    end
  end

  namespace :api, module: :api do
    resources :instances, only: %w(create update)
  end
end
