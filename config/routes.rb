

Rails.application.routes.draw do
  root 'instances#index'

  resources :instances, only: %w(index show), as: :agent_instances
end
