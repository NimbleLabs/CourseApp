Rails.application.routes.draw do

  resources :photos
  scope module: 'admin', path: '/admin' do
    resources :courses, as: 'admin_courses'
    resources :units, as: 'admin_units'
    resources :lessons, as: 'admin_lessons'
  end

  get 'courses', to: 'courses#index', as: 'courses'
  get 'course/:id', to: 'courses#show', as: 'course'

  get 'units', to: 'units#index', as: 'units'
  get 'unit/:id', to: 'units#show', as: 'unit'

  get 'lesson/:id', to: 'lessons#show', as: 'lesson'

  get 'admin', to: 'admin#index', as: 'admin'
  devise_for :users
  get 'home/index'
  get 'privacy', to: 'home#privacy', as: 'privacy'
  get 'terms', to: 'home#terms', as: 'terms'
  get 'home/index'
  root to: 'home#index'
end
