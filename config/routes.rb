Rails.application.routes.draw do

  root to: 'districts#index'

  get '/election' => 'election#show'
  get '/district' => 'district#index'
  get '/district' => 'district#show'

end
