# Vote BC

Vote BC is a data visualizer for presenting election data for past elections. http://vote-bc.ca

![BC Legislative Assembly](app/assets/images/vote-bc-wide-cover.jpg?raw=true "Vote BC")

## Setup Instructions

1. Clone repo
2. Install `rbenv`
   - Install `ruby-2.7.2`
3. Install `postgres`
   - Make sure your root username has psql createdb permission `ALTER USER user CREATEDB;`
4. Set up ruby environment:
   - `bundle update --bundler`
   - `bundle install`
5. Set up database:
   - `rake db:restore`
6. Start rails:
   - `rails s`

## Modifying the Database

The data for elections is pretty static... as it only changes every 4 years or so!

Rather than interpretting the data from scratch every time we want to deploy, its much better to use `rake db:restore` which recreates the database and imports tables and rows from a `.dump` file.

Changes to the schema will require `rake db:migrate`.

Changes to the data processing will require `rake db:seed`. This will collect district boundary data from [OpenNorth](https://opennorth.ca/), read election data from official Elections BC files, and import some self-researched information.

Any database changes during development should be followed with `rake db:dump` and committed.
