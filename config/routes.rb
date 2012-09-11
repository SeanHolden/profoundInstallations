ProfoundInstallations::Application.routes.draw do

  resources :contact
  root :to => 'home#index'

  match '/about' => 'home#about'
  match '/gallery' => 'home#gallery'
  match '/testimonials' => 'home#testimonials'
  match 'messagesent' => 'home#messagesent'

  # Gallery
  match '/gallery/:nameofdirectory' => 'home#gallery_album'
  
end