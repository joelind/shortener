ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'urls', :action => 'index'
  map.resources :urls, :only => [:show, :create, :new, :edit, :update]
  map.resources :tags, :only => :index
  map.short '/:id', :controller => 'urls', :action => 'redirect'
end
