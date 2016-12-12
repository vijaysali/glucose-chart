Rails.application.routes.draw do

  resources :glucose_meters do
    get 'todays'
    get 'last_month'
    get 'custom_range'
  end
  root 'glucose_meters#new'

  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

end
