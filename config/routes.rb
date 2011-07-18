Andy30::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match 'user_sessions/new' => redirect("/")
  resources :user_sessions  
  resources :users
  resources :bookmarks
  resources :updates
  resources :items
  
  match 'short' => 'application#shorten_url'
  match 'tweetables' => 'application#tweetables'
  match 'tgeo' => 'application#get_twitter_places'
  match 'reader' => 'items#index'
  match 'readings' => 'bookmarks#index', :as => [:public_bookmarks, :readings]
  match 'l' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'admin' => 'admin#index', :as => :admin
  match 'citingthetext' => redirect("/writing")
  match 'posts.atom' => redirect("/posts.rss")
  match 'posts' => 'posts#index'
  match 'photos' => 'images#index'
  match 'latest' => 'updates#index'
  match '/bio' => redirect("/about")
  match 'writing' => 'posts#index'
  match ':permalink' => 'posts#show'
  match 'blog' => 'posts#index'
  match 'images/tsa_blog.png' => redirect("/system/images/6/original/tsa_blog.png")  
  match 'images/tsa.jpg' => redirect("/system/images/5/original/TSA.jpg?1291511977")
  match 'photos/:permalink' => 'images#show', :as => :images
  

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

  
  namespace :admin do
    resources :posts
    resources :updates
    resources :images
    resources :bookmarks
    resources :subscriptions
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
