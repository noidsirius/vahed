Rails.application.routes.draw do
  resources :recruits

  resources :reports

  resources :profiles

  resources :changes

  get 'welcome/index'

  devise_for :admins
  resources :fields

  devise_for :users
  
  get 'plans/dashboard' => 'plans#dashboard'

  get 'search/unit_search' => 'search#unit_search'

  get 'plans/switch/:id' => 'plans#switch'

  get 'plans/show_pdf/:id' => 'plans#show_pdf'

  get 'join_acm' => 'welcome#join_acm'

  post 'add_unit' => 'add_unit#index'

  match 'delete_unit' , to: 'add_unit#delete_unit' , via: :delete


  resources :plans

  resources :courses

  resources :units

  resources :professors

  resources :terms

  resources :majors

  match 'upload/upload_arshad_file' ,to: 'upload#upload_arshad_file' ,via: :post
  match 'upload/upload_file' ,to: 'upload#upload_file' ,via: :post
  match 'upload/repair_units' ,to: 'upload#repair_units' ,via: :post
  match 'upload/add_requirements' ,to: 'upload#add_requirements' ,via: :post
  match 'upload/export_users' ,to: 'upload#export_users' ,via: :post
  

  root 'welcome#index'
  

  # get 'alaki', to: 'plans#alaki'
  # get 'alaki2/:id', to: 'plans#alaki2'



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
  match ":controller(/:action(/:id(.:format)))" , via: :get
end
