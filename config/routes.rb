Rails.application.routes.draw do
  resources :collects
  get 'search' => 'slack_rails#index'
  # todo_workのroute
  post 'todo_work/:channel/delete_todolist' => 'todo_work#delete_todolist'
  get 'todo_work/:channel' => 'todo_work#index'
  post 'todo_work/:channel' => 'todo_work#modify'
  # searchのroute
  get 'search/query' => 'slack_rails#query'
  get 'search/link' => 'slack_rails#link'
  post 'search' => 'slack_rails#search'
  post 'search_link' => 'slack_rails#search_link'
  get 'search/:channel' => 'slack_rails#channel'
  post 'save' => 'slack_rails#save'
  post 'save_lodge' => 'slack_rails#save_lodge'
  root 'collects#search'
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
