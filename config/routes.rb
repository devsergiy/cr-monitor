Rails.application.routes.draw do
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
