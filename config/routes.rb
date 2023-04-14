Rails.application.routes.draw do
  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get '/about' => "homes#about", as: "about"
    get 'customers/mypage' => "customers#show", as: "mypage"
    get 'customers/edit'
    get 'customers/update'
    get 'customers/exit'
    get 'customers/unsbscribe'
  end

  namespace :public do
  end

  # 管理者用
  devise_for :admin,skip: [:registrations,:passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
