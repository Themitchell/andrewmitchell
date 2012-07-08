AndrewMitchell::Application.routes.draw do
  namespace :admin do resources :posts end

  namespace :admin do root :to => 'dashboard#index' end

  post        '/auth/:provider/callback'              => 'authentications#create'
  get         '/profile/connected-providers'          => 'authentications#index', :as => 'authentications'
  delete      '/profile/connected-provider/:provider' => 'authentications#destroy', :as => 'authentication'

  devise_for  :users, :controllers => { :registrations => 'registrations' }
  resources   :users


  ### FRONTEND ###

  # Static Pages
  get         '/contact'  => 'static_pages#contact'

  # About
  get         '/about'                      => 'about#index'
  get         '/employment-history'         => 'about#employment_history',          :as => 'employment_history'
  get         '/educational-qualifications' => 'about#educational_qualifications',  :as => 'educational_qualifications'

  # Comments
  resources   :comments

  # Posts
  resources   :posts, :only => [:show, :index] do
    resources   :comments, :except => [:delete]
  end
  get         'posts/category/:category_permalink'  => 'posts#category', :as => 'posts_category'
  get         'posts/tagged/:tag'                   => 'posts#tagged'

  # Portfolio
  get '/portfolio' => 'portfolio#index'
  get '/portfolio/:id' => 'portfolio#show'
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
