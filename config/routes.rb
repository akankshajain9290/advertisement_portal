Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ##########################################################################################################
  # Routes for User Login and Registration
  ##########################################################################################################
  scope module: 'devise' do
    get '/sign_in', to: 'sessions#new'
    post '/sign_in', to: 'sessions#create'
    delete '/sign_out', to: 'sessions#destroy'
    get '/sign_up', to: 'registrations#new'
    post '/sign_up', to: 'registrations#create'
  end

  ##########################################################################################################
  # Routes for Dashboard
  ##########################################################################################################
  get '/dashboard', to: 'home#dashboard'

  ##########################################################################################################
  # Routes for Slots and Bids
  ##########################################################################################################
  resources :slots, except: :show do
     resources :bids, only: [:create, :update]
  end

  ##########################################################################################################
  # Routes for Adv Spaces
  ##########################################################################################################
  resources :adv_spaces, except: [:index, :show]

  root 'home#dashboard'
end
