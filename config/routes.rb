Rails.application.routes.draw do

  resources :glucose_meters
  root 'users#dashboard'

  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  #root "layouts#applicaiton"

end
