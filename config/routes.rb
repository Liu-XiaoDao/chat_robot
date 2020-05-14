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
    # 下面是图书管理相关
    get 'golden_ideas',        on: :member
    get 'exchange_records',    on: :member
    get 'assign_score_records',    on: :member
    get 'score',    on: :member
    get 'score_lists',    on: :collection
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
    get 'assign_view', on: :member
    post 'assign',     on: :member
    get 'return_book', on: :member
    get 'recycle_book', on: :member
    get 'continue_borrow', on: :member
    #批量导入
    post 'import',     on: :collection
    get  'export',     on: :collection
    #所有评论
    get  'all_comments',on: :member
    #扫描条形码
    get 'scan_barcode', on: :collection
    get 'scan_barcode_insert_isbn', on: :collection
  end
  resources :book_classifications do
    get 'index_admin', on: :collection
    get 'show_admin',  on: :member
  end

  get '/library' => 'library#index' #图书管理首页
  get '/library/borrow_books' => 'library#borrow_books' #图书管理正在被借阅
  get '/library/borrow_records' => 'library#borrow_records' #图书管理借阅记录
  get '/library/praise_rubbishs' => 'library#praise_rubbishs' #图书管理评价
  get '/library/comments' => 'library#comments' #图书管理评论
  get '/library/return_records' => 'library#return_records' #图书管理归还记录

  resources :attachments

  # 下面是金点子相关
  get '/golden_idea' => 'golden_idea/application#index'
  get '/golden_idea_good_exchange_records' => 'golden_idea/application#exchange_records'
  get '/golden_idea_assign_score_records' => 'golden_idea/application#assign_score_records'
  get '/golden_idea_employee_score_order' => 'golden_idea/application#employee_score_order'
  get '/golden_idea_score_order' => 'golden_idea/application#golden_idea_score_order'
  get '/golden_idea_user_requests' => 'golden_idea/application#user_requests'
  get '/golden_idea_dashboard' => 'golden_idea/application#dashboard'
  namespace :golden_idea do
    resources :seasons do
      # get 'index_admin', on: :collection
      # get 'show_admin',  on: :member
    end
    resources :ideas do
      get 'search',      on: :collection
      # get 'index_admin', on: :collection
      get 'current_season_index', on: :collection
      # get 'current_season_index_admin', on: :collection
      # get 'show_admin',  on: :member
      # get 'edit_content',on: :member
      get 'score_view',  on: :member
      get 'employee_score_view',  on: :member
      post 'employee_score',  on: :member
      get 'import',     on: :collection
      post 'import_preview',     on: :collection
    end
    resources :goods do
      get 'index_admin', on: :collection
      get 'show_admin',  on: :member
      get 'exchange_view',  on: :member
      patch 'exchange',  on: :member
    end
    resources :exchange_records do
      get 'complete',  on: :member
    end
    resources :suggests do
      get 'reply', on: :member
    end
  end

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
