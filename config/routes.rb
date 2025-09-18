Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    devise_for :users

    root "pages#main"

    get "help",  to: "pages#help"
    get "about", to: "pages#about"

    # Темы и изображения (вьюхи)
    resources :themes, only: [:index]
    resources :images, only: [:show]

    # Экспертные оценки (форма на главной)
    resources :expert_ratings, only: [:create]

    # Моя страница (профиль)
    get "me", to: "profiles#show", as: :my_page

    # Переключение языка
    get "locale/:locale", to: "locale#switch", as: :switch_locale

    # API v1 (перелистывание и сохранение оценки)
    namespace :api do
      namespace :v1 do
        resources :themes, only: [] do
          resources :images, only: [:index] # GET /api/v1/themes/:theme_id/images?page=
        end
        resources :images, only: [] do
          resources :expert_ratings, only: [:create] # POST /api/v1/images/:image_id/expert_ratings
        end
      end
    end
  end
end
