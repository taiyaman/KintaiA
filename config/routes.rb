Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  #拠点情報のルーティング設定
  resources :bases
 

  resources :users do
    collection do 
      post 'import'
      get 'index_attendance' #出勤中の従業員一覧を表示
      get 'user_basic_update' 
    end
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month' # この行が追加対象です。
      patch 'attendances/update_one_month' # この行が追加対象です。
      get 'attendances/edit_overtime_request' # この行が追加対象です。
      patch 'attendances/update_overtime_request'
      get 'attendances/edit_attendance_up'
      patch 'attendances/update_attendance_up'
      get 'applies/edit_one_month' # /users/:id/applies/update_one_month(:format)
      patch 'applies/update_one_month'
      get 'attendances/show_attendance_log'
      get 'attendances/edit_attendance_log'
    end
    resources :attendances, only: [:update] do
      collection do 
      end
      member do
        get 'edit_overtime_request'
        get 'edit_notice_overtime'
        get 'attendances/edit_attendance_up'
        get 'attendances/show_attendance_log'
        patch 'update_overtime_request'
        patch 'update_notice_overtime'
        patch 'attendances/update_attendance_up' #/users/:user_id/attendances/:id/attendances/edit_attendance_up(.:format)
        get 'attendances/edit_attendance_log'
        get 'attendances/update_attendance_log'
        get 'attendances/edit_one_month_show'
      end
    end
    resources :applies do
      member do
        patch 'update_one_month'
        get 'edit_one_month'  # /users/:id/applies/update_one_month(:format)
        get 'edit_one_month_show'
      end
    end
  end
end