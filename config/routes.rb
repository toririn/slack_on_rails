Rails.application.routes.draw do
  path_prefix = Constants::ROOT_PATH_PREFIX

  scope path_prefix do
    root to: "sessions#index"

    resources :tops, only: [:index]

    namespace :togethers do
      post "searchs/output"

      resources :link_searchs, only: [:index]
      post "link_searchs/search"

      resources :query_searchs, only: [:index]
      post "query_searchs/search"

      resources :seted_channel_searchs, only: [:index]
      post "seted_channel_searchs/search"
      post "seted_channel_searchs/:channel" => "seted_channel_searchs#show"
      get  "seted_channel_searchs/:channel" => "seted_channel_searchs#show"
    end

    # タスク管理関係
    resources :todo_managements, only: [:index]
    post "todo_managements/:channel/update" => 'todo_managements#update'
    get  "todo_managements/:channel"        => 'todo_managements#show'
    post "todo_managements/:channel"        => 'todo_managements#show'
    post "todo_managements/:channel/create" => 'todo_managements#create'

    resources :otacks, only: [:index]
    get   "otacks/show"   => 'otacks#show'
    get   "otacks/search" => 'otacks#search'

    resources :sessions, only: [:index]
    get  "sessions/destroy"
    post "sessions/login"

    # Slackとの認証関係
    post "auth/:provider/callback"  => 'sessions#create'
    get  "auth/:provider/callback"  => 'sessions#create'
  end
  get "*anything" => 'errors#routing'
end
