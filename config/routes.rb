Simplecrowd::Application.routes.draw do
  root 'home#index'
  #root "pages#home"

  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  
  get "posts", to: "pages#posts", as: "posts"
  get "posts/:id", to: "pages#show_post", as: "post"    
  devise_for :users
  
  namespace :admin do
    root "base#index"
    resources :users
    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    get "posts/dashboard", to: "posts#dashboard", as: "posts_dashboard"
    resources :posts
  end

  ################################################################################
  # ADDED start
  #
  resources :projects

  #root 'home#index'

  get 'home/index'

  if Rails.env.development?
    # catch-all, for easy testing of arbitrary views without having to add routes (or controller mappings) for them
    get ':controller(/:action(/:id(.:format)))'

    # /assets is symlinked into public/assets, this construct is used for SASS source maps (with FF/Chrome dev tools)
    get "/assets" => redirect("http://localhost:3002/public/assets")
  end
  #
  # ADDED end
  ################################################################################

end
