# Vote BC

Vote BC is a data visualizer for presenting election data for past elections.

http://vote-bc.ca

## Setup instructions
* Install rbenv 
* Make sure your root username has psql createdb permission `ALTER USER user CREATEDB;`
* `rake db:create`
* `rake db:migrate`
* `rake db:seed`
* `rake db:seed`
* `rails s`
