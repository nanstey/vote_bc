Rails.application.routes.draw do

  root to: 'election#show'

  get '/:year' => 'election#show'
  get '/districts' => 'district#index'
  get '/districts/:name' => 'district#show'

end
