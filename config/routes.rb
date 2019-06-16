Rails.application.routes.draw do
  
  #카카오
  get '/keyboard' => 'chat#keyboard'
  get '/message' => 'chat#message'
  post '/message' => 'chat#message'
  post '/friend' => 'chat#add_friend'
  delete '/friend/:user_key' => 'chat#delete_friend'
  delete '/chat_room/:user_key' => 'chat#chat_room'
  
  #api
  get '/api/user_words/user_key/:user_key' => 'api#getUserWordsByUserKey'
  get '/api/menu/update' => 'api#updateAllMenu'
  get '/api/menu_domitory/update' => 'api#updateAllDomitoryMenu'
  get '/api/menu_domitory/update/yesterday' => 'api#updateYesterdayToggle'
  get '/api/menu_domitory/update/use_db' => 'api#updateDbToggle'
  get '/api/menu_domitory/update/medi/use_db' => 'api#updateDbMediToggle'
  get '/api/menu_domitory/update/hu/use_db' => 'api#updateDbHuToggle'
  get '/api/menu_domitory/update/jungdam/use_db' => 'api#updateDbJungdamToggle'
  get '/api/menu_domitory/update/jinsu/use_db' => 'api#updateDbJinsuToggle'
  get '/api/menu_domitory/update/student_hall/use_db' => 'api#updateDbStudentHallToggle'

  #major
  post '/major' => 'major#create'
  put '/major/:id' => 'major#update'
  delete '/major/:id' => 'major#delete'

  #post
  post '/messages' => 'message#create'
  delete '/messages/:id' => 'message#delete'

  #관리 페이지
  get '/management/main'
  get 'management/main/:content' => 'management#message_detail'
  get '/management/users' => 'management#user'
  get '/management/users/:user_key' => 'management#user_detail'
  get '/management/major'
  get '/management/menu'
  get '/management/message'
  get '/management/backup'
  post '/management/setDB'
  get '/management/sw_menu'
  get '/management/monitoring'


  
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
