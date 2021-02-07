# Vote BC

Vote BC is a data visualizer for presenting election data for past elections. http://vote-bc.ca

![BC Legislative Assembly](app/assets/images/vote-bc-wide-cover.jpg?raw=true "Vote BC")

## Setup instructions

1. Clone repo
2. Install `rbenv`
   - Install `ruby-2.7.2`
3. Install `postgres`
   - Make sure your root username has psql createdb permission `ALTER USER user CREATEDB;`
4. Set up ruby environment:
   - `bundle update --bundler`
   - `bundle install`
5. Set up database
   - `rake db:create`
   - `rake db:migrate`
   - `rake db:seed`
6. Start rails: `rails s`
