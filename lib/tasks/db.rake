namespace :db do

  desc "Dumps the database to db/APP_NAME.dump"
  task :dump => :environment do
    with_uri do |app, uri|
      db = uri.path.sub('/', '')
      cmd = "PGPASSWORD=#{uri.password} pg_dump --host=#{uri.host} --username=#{uri.user} --verbose --clean --no-owner --no-acl --format=plain #{db} > #{Rails.root}/db/#{app}.sql"
      puts cmd
      exec cmd
    end
  end

  desc "Restores the database dump at db/APP_NAME.dump."
  task :restore => :environment do
    with_uri do |app, uri|
      cmd = "psql -d #{uri} --file=#{Rails.root}/db/#{app}.sql --echo-all"
      puts cmd
      exec cmd
    end
  end

  private

  def with_uri
    uri = URI.parse(ENV['DATABASE_URL'])
    raise "DATABASE_URL environment variable is not set!" unless uri.host

    app_name = Rails.application.class.module_parent_name.underscore
    yield app_name, uri
  end

end
