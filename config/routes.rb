Conciage::Application.routes.draw do
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: 'users/registrations',
      sessions: 'users/sessions'
  } do
  end

  get :fill_email, to: 'home#fill_email'
  post :fill_email, to: 'home#update_email'

  #resources :user_profiles, controller: "user_profiles"
  match 'profile', to: 'user_profiles#edit', via: [:get], as: :current_user_profile_edit
  match 'profile', to: 'user_profiles#update', via: [:patch], as: :current_user_profile_update
  get   "profile_page", to: 'user_profiles#profile_page'

  resources :business_profiles
  resources :messages do
    member do
      match 'save', to: 'messages#save', via: [:patch], as: :message_to_saved
      match 'play', to: 'messages#play', via: [:patch], as: :message_to_played
      match 'stop', to: 'messages#stop', via: [:patch], as: :message_to_stopped
      match 'pause', to: 'messages#pause', via: [:patch], as: :message_to_paused
    end
  end
  match 'message_analytics/:id', to: 'messages#analytics', via: [:get], as: :message_analytics

  match 'business_categories/search', to: 'business_categories#search', via: [:get], defaults: { format: 'json' }
  match 'places/search', to: 'places#search', via: [:get], defaults: { format: 'json' }
  match 'countries/search', to: 'countries#search', via: [:get], defaults: { format: 'json' }
  match 'time_zones/search', to: 'time_zones#search', via: [:get], defaults: { format: 'json' }
  match 'time_zones/for_location', to: 'time_zones#for_location', via: [:get], defaults: { format: 'json' }
  match 'states/search', to: 'states#search', via: [:get], defaults: { format: 'json' }
  match 'cities/search', to: 'cities#search', via: [:get], defaults: { format: 'json' }
  match 'zip_codes/search', to: 'zip_codes#search', via: [:get], defaults: { format: 'json' }
  match 'usernames/check', to: 'usernames#check', via: [:get], defaults: { format: 'json' }

  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create] do
        patch :update, on: :collection
        #delete :destroy, on: :collection
      end

      resources :places, only: [:index, :create]
      resources :business_categories, only: [:index]
      resources :messages, only: [:index, :create]
      resources :business_profiles, only: [:index, :create]
    end
  end

  resources "addresses" do
    get "make_main", on: :member
  end
end
