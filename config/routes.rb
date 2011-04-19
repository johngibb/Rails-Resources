RailsResources::Application.routes.draw do
  resources :snippets

  resources :links

  resources :stack_overflow_searches

  root :to => "home#index"
  
  get '/myip' => "home#myip"
end
