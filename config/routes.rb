ProfoundInstallations::Application.routes.draw do

  devise_for :admins, :skip => [:registrations, :passwords] 

  as :admin do
    get "/admin" => "devise/sessions#new"
  end

  resources :cms, :only => [:create]
  resources :contact
  resources :gallery_uploads, :path => '/admin/gallery_uploads'
  resources :image_uploads, :only => [:destroy, :update, :create], :path => '/admin/image_uploads'
  resources :testimonials, :path => '/admin/testimonials'
  resources :about, :only => [:index, :edit, :update], :path => '/admin/about'

  root :to => 'home#index'

  match '/about' => 'home#about'
  match '/gallery' => 'home#gallery'
  match '/testimonials' => 'home#testimonials'
  match 'messagesent' => 'home#messagesent'

  # Gallery
  match '/gallery/:gallery_url' => 'home#gallery_album'

  # Admin dashboard
  match '/admin/dashboard' => 'dashboard#index'
  match '/admin/dashboard/gallery' => 'dashboard#gallery'

end