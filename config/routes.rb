AndrewMitchell::Application.routes.draw do

  get         "portfolio/index"
  get         "portfolio/show"

  post        '/auth/:provider/callback' => 'authentications#create'
  get         '/profile/connected-providers' => 'authentications#index', :as => 'authentications'
  delete      '/profile/connected-provider/:provider' => 'authentications#destroy', :as => 'authentication'

  devise_for  :users, :controllers => { :registrations => 'registrations' }
  resources   :users


  ### FRONTEND ###
  
  # Static Pages
  get         '/about'    => 'static_pages#about'
  get         '/contact'  => 'static_pages#contact'
  resources   :comments
  
  # Posts
  resources   :posts, :only => [:show, :index] do
    resources   :comments, :except => [:delete]
  end
  get         'posts/category/:category_permalink' => 'posts#category', :as => 'posts_category'
  get         'posts/tagged/:tag' => 'posts#tagged'
  
  # Portfolio
  get       '/portfolio'  => 'portfolio#index'
  # resources :portfolio, :only => [:index] do
  #   resources :comments, :except => [:delete]
  # end
  # match 'portfolio/category/:category_permalink' => 'portfolio#category', :as => 'portfolio_category'
  # match 'portfolio/tagged/:tag' => 'portfolio#tagged'
  
  # Photos & Albums
  resources :photoalbums, :only => [:index, :show] do
    resources :pictures, :only => [:show] do
      resources :comments, :except => [:delete]
    end
  end
  match 'pictures/tagged/:tag' => 'pictures#tagged'

  root :to => "posts#index"
end
