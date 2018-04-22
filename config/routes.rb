Rails.application.routes.draw do


  root 'questions#index'
  get 'questions/search' => 'questions#search'
  resources :questions do
    post 'upload_img', on: :collection
  end
  resources :categorys

  resources :links do
    get 'display_list', on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
