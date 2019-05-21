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
    post 'set_my_phone_number',on: :collection
    get 'set_my_phone_number_page',on: :collection
    # 下面是图书管理相关
    get 'borrow_record',       on: :member
    get 'return_record',       on: :member
    get 'borrow_book',         on: :member
    get 'book_praise_rubbish', on: :member
    get 'book_comment',        on: :member
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
    get 'statistics',on: :collection
  end

  resources :books do
    resources :comments
    get 'index_admin', on: :collection
    get 'search',      on: :collection
    get 'praise',      on: :member
    get 'rubbish',     on: :member
    get 'borrow_view', on: :member
    post 'borrow',     on: :member
    get 'return_book', on: :member
    get 'continue_borrow', on: :member
    #批量导入
    post 'import',     on: :collection
    get  'export',     on: :collection
    #所有评论
    get  'all_comments',on: :member
  end
  resources :book_classifications do
    get 'index_admin', on: :collection
    get 'show_admin',  on: :member
  end

  get '/library' => 'library#index' #图书管理首页
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
