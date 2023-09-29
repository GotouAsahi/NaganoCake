Rails.application.routes.draw do
  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    resources :items, only: %i[index show]
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/information/edit' => 'customers#edit', as: 'customers_edit'
    patch 'customers/information' => 'customers#update', as: 'customers_update'
    get 'customers/unsbscribe'
    patch 'customers/withdrow'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: %i[index update create destroy]
    post 'orders/confirmation', as: 'confirmation'
    get 'orders/completion', as: 'completion'
    resources :orders, only: %i[new create index show]
    resources :addresses, except: %i[new show]
  end

  # 管理者用
  devise_for :admin, skip: %i[registrations passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
    resources :items, except: [:destroy]
    resources :genres, only: %i[index edit create update]
    resources :customers, only: %i[index show edit update]
    resources :orders, only: %i[index show update]
    patch 'order_details/:id' => 'order_details#update', as: 'order_detail'
    post 'search' => 'searches#search'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
