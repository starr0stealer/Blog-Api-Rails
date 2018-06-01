Rails.application.routes.draw do
  scope path: '/', defaults: { format: :json } do
    devise_for   :users, skip: :all
    devise_scope :user do
      post   :register, to: 'devise/registrations#create', as: nil
      post   :login,    to: 'devise/sessions#create',      as: nil
      delete :logout,   to: 'devise/sessions#destroy',     as: nil
    end
  end
end
