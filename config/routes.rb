Rails.application.routes.draw do

  post 'conversations', to: 'conversations#create'
  post 'message/:id', to: 'conversations#send_message'
  get 'messages/:id', to: 'conversations#messages'

  get 'go-pro', to: 'home#pricing', as: 'pricing'
  resources :photos

  scope module: 'admin', path: '/admin' do
    resources :courses, as: 'admin_courses'
    resources :units, as: 'admin_units'
    resources :lessons, as: 'admin_lessons'
    resources :posts, as: 'admin_posts'
    resources :conversations, as: 'admin_conversations'
    post 'message/:id', to: 'conversations#send_message'

    # authenticate :user, lambda {|u| u.admin?} do
    #   mount Sidekiq::Web => '/sidekiq'
    # end
  end

  resources :credit_cards, path: '/payments'
  get 'plans/pro', to: 'plans#pro', as: 'pro_plan'
  get 'plans/pro-lifetime', to: 'plans#lifetime_pro', as: 'lifetime_pro'

  get 'courses', to: 'courses#index', as: 'courses'
  get 'course/:id', to: 'courses#show', as: 'course'
  get 'module/:id', to: 'units#show', as: 'unit'
  get 'lesson/:id', to: 'lessons#show', as: 'lesson'
  get 'posts', to: 'posts#index', as: 'posts'
  get 'posts/:id', to: 'posts#show', as: 'post'

  get 'admin', to: 'admin#index', as: 'admin'
  devise_for :users, :path_names => {:sign_in => 'signin', :sign_up => 'register', :sign_out => 'logout'},
             :controllers => {registrations: 'registrations'}

  get 'home/index'
  get 'privacy', to: 'home#privacy', as: 'privacy'
  get 'terms', to: 'home#terms', as: 'terms'
  get 'home/index'
  root to: 'home#index'
end
