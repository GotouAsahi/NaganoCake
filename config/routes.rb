Rails.application.routes.draw do

  namespace :admin do
    get 'order_details/update'
  end
  namespace :admin do
    get 'orders/show'
    get 'orders/update'
  end
  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get '/about' => "homes#about", as: "about"
    resources :items,only: [:index,:show]
    get 'customers/mypage' => "customers#show", as: "mypage"
    get 'customers/information/edit' => "customers#edit", as: "customers_edit"
    patch 'customers/information' => "customers#update", as: "customers_update"
    get 'customers/unsbscribe'
    patch 'customers/withdrow'
    delete '/cart_items/destroy_all' => "cart_items#destroy_all"
    resources :cart_items,only: [:index,:update,:create,:destroy]
    post 'orders/confirmation',as: "confirmation"
    get 'orders/completion',as: "completion"
    resources :orders,only: [:new,:create,:index,:show]
    resources :addresses ,except: [:new,:show]
  end


  # 管理者用
  devise_for :admin,skip: [:registrations,:passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :items,except: [:destroy]
    resources :genres,only: [:index,:edit,:create,:update]
    resources :customers,only: [:index,:show,:edit,:update]
    resources :orders,only: [:index,:show,:update]
    patch 'order_details/:id' => 'order_details#update', as: 'order_detail'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
