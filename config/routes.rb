Rails.application.routes.draw do
  path = ROOT_PATH
  get "#{path}search" => 'slack_rails#index'
  # todo_workのroute
  post "#{path}todo_work/:channel/delete_task" => 'todo_work#delete_task'
  get "#{path}todo_work/:channel" => 'todo_work#index'
  post "#{path}todo_work/:channel" => 'todo_work#modify'
  # searchのroute
  get "#{path}search/query" => 'slack_rails#query'
  get "#{path}search/link" => 'slack_rails#link'
  post "#{path}search" => 'slack_rails#search'
  post "#{path}search_link" => 'slack_rails#search_link'
  get "#{path}search/:channel" => 'slack_rails#channel'
  post "#{path}save" => 'slack_rails#save'
  post "#{path}save_lodge" => 'slack_rails#save_lodge'
  root "#{path}sessions#index"
  post "#{path}auth/:provider/callback" => 'sessions#create'
  post "#{path}login" => 'sessions#login'
  get  "#{path}auth/:provider/callback" => 'sessions#create'
  get  "#{path}logout" => 'sessions#destroy'
  get  "#{path}top" => 'slack_rails#top'
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
