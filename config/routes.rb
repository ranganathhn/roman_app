Rails.application.routes.draw do
 root "romans#index"
 resources :romans, :only => ["index"] do
 	get :calculate, :on => :collection
 end
end
