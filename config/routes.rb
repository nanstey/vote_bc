Rails.application.routes.draw do

  root to: 'election#show'

  get '/election/:year' => 'election#show'
  get '/districts' => 'district#index'
  get '/district/:name' => 'district#show'

end
