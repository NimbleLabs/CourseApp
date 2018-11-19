Rails.application.routes.draw do
  get 'home/index'
  get 'privacy', to: 'home#privacy', as: 'privacy'
  get 'terms', to: 'home#terms', as: 'terms'
  get 'home/index'
  root to: 'home#index'
end
