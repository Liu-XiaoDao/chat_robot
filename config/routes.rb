Rails.application.routes.draw do


  root 'questions#index'
  get 'questions/search' => 'questions#search'
  resources :questions do
    post 'upload_img', on: :collection
    get  'advanced_search', on: :collection
    get  'praise', on: :member
    get  'rubbish', on: :member
  end
  resources :categorys

  resource :chatbot do
    get 'get_answer', on: :collection
  end
  resources :links do
    get 'display_list', on: :collection
    get 'display_icon', on: :collection
    get 'code_scan', on: :collection
  end

  resources :departments do
    get 'update_department', on: :collection
  end

  resources :employees do
    get 'update_employee', on: :collection
    get 'phone_number', on: :collection
    post 'set_phone_number',on: :member
    get 'show_phone_number',on: :collection
  end

  resources :apis do
    post 'getuserid', on: :collection
    post 'get_userinfo', on: :collection
    get 'get_department', on: :collection
    get 'jsapi_oauth', on: :collection
    get 'send_message', on: :collection
  end

  resources :expresses do
    post 'batch_create', on: :collection
  end

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
