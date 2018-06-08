Rails.application.routes.draw do
  scope path: '/', defaults: { format: :json } do
    devise_for   :users, skip: :all
    devise_scope :user do
      post   :register, to: 'devise/registrations#create', as: nil
      post   :login,    to: 'devise/sessions#create',      as: nil
      delete :logout,   to: 'devise/sessions#destroy',     as: nil
    end

    resources :users, param: :username, only: [:show, :update] do
      get :current, on: :collection
    end

    resources :articles, param: :slug, except: [:edit, :new] do
      resources :comments, only: [:index, :create, :destroy]
      resource  :favorite, only: [:create, :destroy]
    end
  end
end
