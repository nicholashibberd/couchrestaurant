Couchrestaurant::Application.routes.draw do
  
  #map.task_archive 'pages/:year/:month', :controller => 'pages', :action => 'show'
  
  resources :nav_menus
  resources :menus do
    resources :dishes do
      member do 
        post 'update_dish'
      end
    end
    resources :menu_sections do
      member do 
        post 'update_menu_section'
      end
    end
  end 
  match "update_dish" => "dishes#update_dish"
  match "create_dish" => "dishes#create_dish"
  match "update_sitting" => "sittings#update_sitting"
  match "create_sitting" => "sittings#create_sitting"
  match "update_nav_menu" => "nav_menus#update_nav_menu"

  resources :sites
  resources :sittings
  resources :pages do 
    collection do
      post 'new_page'
    end
    member do
      get 'edit_unit'
    end
    resources :units do
      member do 
        post 'update_unit'
        post 'add_column'
      end
      collection do
        post 'create_unit'
        post 'create_table_unit'
      end
    end
  end 
  resources :nav_items
  resources :images do 
    collection do
      post 'new_image'
    end
  end
  resources :downloads do 
    collection do
      post :download_document
    end
  end
  resources :reservations do
    collection do
      get 'availability', 'details', 'choose_dates','thankyou', 'calendar'
      post 'availability', 'details', 'choose_dates', 'calendar'
    end
  end
  resources :messages  
  match 'admin' => 'admin#index'
  match 'admin/new_nav_item' => 'admin#new_nav_item'
  match 'admin/edit_nav_items' => 'admin#edit_nav_items'
  #root :to => 'pages/show/home'
  match '/pages/:id/edit' => 'pages#edit'
  match '/menus/:id/edit' => 'menus#edit'
  match '/pages/:id/:sub_id' => 'pages#show', :as => :child_page
  match '/pages/:id/:sub_id/edit' => 'pages#edit', :as => :edit_child_page

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
