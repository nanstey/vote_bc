Rails.application.routes.draw do

  root to: 'election#show'

  get '/:year' => 'election#show'
  get '/districts' => 'district#index'
  get '/:name' => 'district#show'

end
