Rails.application.routes.draw do

  root to: 'election#show'

  get '/election/:year' => 'election#show'
  get '/districts' => 'district#index'
  post '/districts' => 'district#search'
  get '/district/:name' => 'district#show'
  get '/district/:name/:year' => 'district#show'

end
