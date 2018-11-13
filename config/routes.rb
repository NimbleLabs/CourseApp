Rails.application.routes.draw do

  scope module: 'admin', path: '/admin' do
    resources :courses, as: 'admin_courses'
  end

  resources :courses
  get 'admin', to: 'admin#index', as: 'admin'
  devise_for :users
  get 'home/index'
  root to: 'home#index'
end
