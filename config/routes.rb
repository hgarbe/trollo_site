Rails.application.routes.draw do
  root "boards#index"


  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users do
    resources :boards
  end

  resources :boards, shallow: true do
    resources :lists, shallow: true do
      resources :tasks
    end
  end
end
