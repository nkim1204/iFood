ActionController::Routing::Routes.draw do |map|
  map.resources :user_ingredients

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.home '/users/home', :controller => 'users', :action => 'home'
  map.delete_category 'ingredient_categories/destroy/:id', :controller=> 'ingredient_categories', :action => 'destroy'
  map.edit_category 'ingredient_categories/edit/:id', :controller=> 'ingredient_categories', :action => 'edit'
  map.edit_ingredient 'ingredients/edit/:id', :controller=> 'ingredients', :action => 'edit'
  map.delete_ingredient 'ingredients/destroy/:id', :controller => 'ingredients', :action => 'destroy'
  map.destroy_user_ingredient 'user_ingredients/destroy/:id', :controller => 'user_ingredients', :action => 'destroy'
  map.change_password 'users/change_password', :controller => 'users', :action => 'change_password'
  map.edit_user 'users/edit', :controller => 'users', :action => 'edit'
  map.list_users 'users/list', :controller => 'users', :action => 'list'
  map.delete_user 'users/destroy/:id', :controller => 'users', :action => 'destroy'
  map.delete_recipe 'recipes/destroy/:id', :controller => 'recipes', :action => 'destroy'

  map.edit_recipe 'recipes/edit/:id', :controller => 'recipes', :action => 'edit'
  map.forgot    '/forgot',                    :controller => 'users',     :action => 'forgot'
  map.reset     'reset/:reset_code',          :controller => 'users',     :action => 'reset'


map.ingredients_autocomplete 'ingredients/select_for_recipe', :controller => 'ingredients', :action => 'select_for_recipe'

  map.resources :users
  map.resources :ingredient_categories
  map.resources :ingredients
  map.resources :recipes

  map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "base"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
