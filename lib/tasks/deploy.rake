PREVIOUS_FILE = ".previous-deploy"
PREVIOUS = ENV['PREVIOUS'] || ( File.read(PREVIOUS_FILE).chomp if File.exists?(PREVIOUS_FILE) )
BRANCH   = ENV['BRANCH'] || "master"

task :deploy => ['deploy:record', 'deploy:push', 'deploy:restart']

namespace :deploy do
  task :migrations => [:push, :off, :migrate, :restart, :on, :record]
  task :rollback => [:off, :push_previous, :restart, :on]

  task :push => :check_migrations do
    puts 'Deploying site to Heroku ...'
    puts `git push heroku #{BRANCH}:master -f`
  end
  
  task :restart do
    puts 'Restarting app servers ...'
    puts `heroku restart`
  end
  
  task :fetch do
    puts 'Fetching from heroku'
    puts `git fetch heroku`
  end
  
  task :record => :fetch do
    current_release = `git log remotes/heroku/master --oneline | head -n 1 | cut -d ' ' -f 1`.chomp
    File.open(PREVIOUS_FILE, "w") { |f| f.puts current_release }
  end
  
  task :migrate do
    puts 'Running database migrations ...'
    puts `heroku rake db:migrate`
  end
  
  task :check_migrations do
    local_version = `rails runner 'puts ActiveRecord::Migrator.current_version'`.chomp
    remote_version = `heroku console ActiveRecord::Migrator.current_version`.chomp
    if remote_version >= local_version
      puts 'Migrations up to date.'
    else
      raise "Please run migrations before deploying"
    end
  end
  
  task :off do
    puts 'Putting the app into maintenance mode ...'
    puts `heroku maintenance:on`
  end
  
  task :on do
    puts 'Taking the app out of maintenance mode ...'
    puts `heroku maintenance:off`
  end

  task :push_previous do
    previous_release = PREVIOUS
    if previous_release
      puts "Pushing '#{previous_release}' to Heroku master ..."
      puts `git push heroku +#{previous_release}:master -f`

      puts 'All done!'
    else
      puts "No release tags found - can't roll back!"
    end
  end
end