Actprep::Application.routes.draw do



  resources :homeworks


  match '/pages/formattest' => 'pages#formattes'
  match 'auth/:provider/callback', to: 'sessions#createFacebook'
  match 'auth/failure', to: redirect('/')

  match 'questions/deleteimage/:id' => 'questions#deleteimage'
  match 'questions/explanation/:id' => 'questions#explanation', as: :explanation
  match 'questions/explanation/edit/:id' => 'questions#edit_explanation', as: :explanation_edit
  match 'questions/explanation/postedit/:id' => 'questions#post_edit_explanation', as: :post_edit_explanation

  match '/answers/dashboard' => 'answers#dashboard'
  
  match 'questions/delete' => 'questions#delete'
  match 'questions/edit' => 'questions#edit'
  match 'users/temppass' => 'users#temppass'
  match 'users/edituser' => 'users#editUser'
  match 'questions/maxpage' => 'questions#maxpage'
  
  match 'questions/viewimage/:section/:page' => 'questions#viewimage'
  match 'questions/list' => 'questions#list'
  match 'questions/add' => 'questions#add'
  match 'questions/modify' => 'questions#modify'

  match 'questions/findbyattributes' => 'questions#findbyattributes'


  match "/answers/save" => "answers#save"
  match "/questions/image" => "questions#page_image"
  post 'answers/submit'
  match '/show'=> 'questions#show'
  match 'questions/answer' => 'questions#answer'
  resources :answers
  resources :questions
  match "answers/record" => 'answers#record'
  match "pages/statistics" => 'pages#statistics'



  match 'questions/answer' => 'questions#answer'
  match 'answers/record/:id'  =>  'answers#record'
  match 'pages/homework' => 'pages#homework'
  match 'pages/homework/:id' => 'pages#homework'
  match 'pages/home' => 'pages#home'
  root :to => 'users#profile'

  match 'sessions/new' => 'sessions#new', :as => 'login' 
  match 'sessions/destroy' => 'sessions#destroy', :as => 'logout'
  match 'users/modify' => 'users#modify'
  match 'users/save' => 'users#save'
  match '/users/delete' => 'users#delete'
  
  match '/questionlist'=>'homeworks#questionlist'
  match '/removequestion'=>'homeworks#removequestion'
  
  match '/completionreport' =>'homeworks#completionreport'
  
  match '/profile' => 'users#profile'
  match 'users/sendfriendrequest' => 'users#friendrequest'
  match 'users/approve' => 'users#approve'
  match '/users/unfriend' => 'users#unfriend'
  match '/pages/studentassignment' => 'pages#studentassignment'
  match '/pages/assignhomework/:homeworkid/:studentid' => 'pages#assignhomework'
  match '/pages/unassignhomework/:homeworkid/:studentid' => 'pages#unassignhomework'
  match '/signup' => "sessions#signup"
  match '/sessions/signupsave' => "sessions#signupsave"
  
  match '/quizzes' => "homeworks#quizlist"
  match '/pages/quiz' => "pages#quiz"
   
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
