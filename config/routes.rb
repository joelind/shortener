ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'urls', :action => 'index'
  map.resources :urls, :only => [:show, :create, :new]
  map.short '/:id', :controller => 'urls', :action => 'redirect'
end
