Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    collection do 
      post 'import'
      get 'index_attendance' #出勤中の従業員一覧を表示
    end
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month' # この行が追加対象です。
      patch 'attendances/update_one_month' # この行が追加対象です。
      get 'attendances/edit_overtime_request' # この行が追加対象です。
    end
    resources :attendances, only: [:update] do
      member do
        get 'edit_overtime_request'
      end
    end # この行を追加します。
      
  end
end