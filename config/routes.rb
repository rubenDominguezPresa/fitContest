Rails.application.routes.draw do
  get 'relationships/follow_user'

  get 'relationships/unfollow_user'
  
  get 'challenges', to: 'challenges#index', as: :index_challenges
  post 'challenges/:id/ranking', to: 'challenges#ranking', as: :challenges_ranking
  post 'challenges/:id/posts', to: 'challenges#posts', as: :challenges_posts
  post 'challenges/:id/calendar', to: 'challenges#calendar', as: :challenges_calendar

  post 'challenges/:id/track', to: 'challenges#track', as: :challenges_track

  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  post ':id/follow_challenge', to: 'relationships#follow_challenge', as: :follow_challenge
  post ':id/unfollow_challenge', to: 'relationships#unfollow_challenge', as: :unfollow_challenge

  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through
  get 'notifications', to: 'notifications#index'

  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'posts#index'

  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile

  resources :tracks
  
  resources :posts do
    resources :comments
    member do
      get 'like'
    end
  end

  resources :challenges do
    resources :comments
    member do
      get 'like'
    end
  end

  resources :conversations do
    resources :messages
  end
end
