Rails.application.routes.draw do
  path = Constants::ROOT_PATH
  path_prefix = Constants::ROOT_PATH_PREFIX

  scope path_prefix do
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

    resources :otacks, only: [:index, :show]

    resources :sessions, only: [:index]
    post "sessions/destroy" => "sessions#destory"
  end
  # todo_managementのroute
  post "#{path}todo_management/:channel/complete_task" => 'todo_managements#complete_task'
  get "#{path}todo_management/:channel" => 'todo_managements#index'
  post "#{path}todo_management/:channel" => 'todo_managements#modify'
  post "#{path}todo_management/:channel/report" => 'todo_managements#report'
  # searchのroute
  get  "#{path}" => "sessions#index"
  # Otack関係
  get  "#{path}otacks/show" => 'otacks#show'
  get  "#{path}otacks/index" => 'otacks#index'
  post  "#{path}otacks/search" => 'otacks#search'
  get "*anything" => 'errors#routing'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
