Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#home"
  resources :cocktails do
    collection do
      get :top, to: "cocktails#top"
    end
    member do
      post :upvote
    end
    resources :doses, only: [ :new, :create ]
  end
  resources :doses, only: [ :destroy ]
end
