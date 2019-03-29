Rails.application.routes.draw do
  require 'sidekiq/web'

  authenticated :user, ->(user) { user.has_role? :admin }  do
    mount Sidekiq::Web => '/sidekiq'
  end

  authenticated :user do
    root to: 'users/images#show'
  end

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks',
    masquerades: 'admin/masquerades'
  }

  get 'become_partner' => 'partner#index', as: :become_partner
  root 'landing_page#index'

  resources :taddar_mentions, only: %i(create index)

  namespace :pages do
    resources :contact_us, only: %i(create index)
    resources :demo, only: %i(index)
  end

  namespace :users do
    resources :products, only: %i(show)
  end

  delete 'logout' => 'sessions#destroy'
  get 'instagram_authenticate' => 'instagram#authenticate'
  get '/auth/instagram/callback' => 'instagram#call_back'
  get '/privacy_policy' => 'policies#privacy_policy'
  get '/terms_and_conditions' => 'policies#terms_and_conditions'

  resources :users, only: %i(update destroy)
  resources :cropped_images, only: %i(create update)
  resources :similar_products, only: [:index]

  get 'landing_page' => 'landing_page#index'
  get 'influencer' => 'landing_page#influencer'

  namespace :admin do
    namespace :crawling do
      post 'taddar_vision_export' => 'taddar_vision_export#create', as: :taddar_vision_export
      resources :product_crawlers, except: [:show] do
        member do
          post :execute
        end
        resources :crawl_categories, only: %i(create update destroy)
        resources :root_categories, only: :show
      end
    end

    namespace :commission_factory do
      resources :importers, except: [:show] do
        member do
          post :execute
        end
        resources :categories, only: %i(create update destroy) do
          member do
            post :execute
          end
        end
        resources :root_categories, only: :show
        resources :products_destroyer, only: :create
      end
    end

    resources :users, except: [:show]
    resources :proxies, except: [:show]
  end

  resources :search, only: [:index] do
    collection do
      get :products
      get :users
    end
  end

  namespace :api do
    namespace :v1 do
      resources :similar_products, only: %i(create)
      resources :products, only: %i(index show), param: :uuid
      resources :instagram_authentication, only: [:index]
      resources :users, only: %i(show update), param: :uuid
      resources :instagram_posts, only: %i(index)
      resources :image_of_interests, only: %i(index create destroy show), param: :uuid
      resources :cropped_products, only: %i(create), param: :uuid
      get '/token' => 'instagram_authentication#token'
      resources :search, only: [:index] do
        collection do
          get :products
          get :users
        end
      end
    end
  end

  get ':id' => 'users/outfits#show', as: :user_outfits
  get ':id/images' => 'users/images#show', as: :user_images

  resources :users, only: [], path: ':username' do
    collection do
      resources :categories, only: [:index] do
        member do
          get :products
        end

        collection do
          get :hierachy
        end
      end

      get 'setup' => 'setup#edit'
      get 'complete' => 'setup#complete'
      patch 'update_profile' => 'setup#update_profile'
      get 'my_account' => 'users#my_account'
      get 'instagram_images' => 'instagram#instagram_images'
    end
  end
end
