PREVIOUS_FILE = ".previous-deploy"
PREVIOUS = ENV['PREVIOUS'] || ( File.read(PREVIOUS_FILE).chomp if File.exists?(PREVIOUS_FILE) )
BRANCH   = ENV['BRANCH'] || "master"

task :deploy => ['deploy:record', 'deploy:push', 'deploy:restart']

def run(cmd)
  out = `#{cmd}`
  if $?.to_i > 0
    raise "Command #{cmd} returned status code #{$?}\n" + out
  end
  out.chomp
end

namespace :deploy do
  task :migrations => [:push, :off, :migrate, :restart, :on, :record]
  task :rollback => [:off, :push_previous, :restart, :on]

  task :push => :check_migrations do
    puts 'Deploying site to Heroku ...'
    puts run("git push heroku #{BRANCH}:master -f")
  end
  
  task :restart do
    puts 'Restarting app servers ...'
    puts run('heroku restart')
  end
  
  task :fetch do
    puts 'Fetching from heroku'
    puts run('git fetch heroku')
  end
  
  task :record => :fetch do
    current_release = run("git log remotes/heroku/master --oneline | head -n 1 | cut -d ' ' -f 1")
    File.open(PREVIOUS_FILE, "w") { |f| f.puts current_release }
  end
  
  task :migrate do
    puts 'Running database migrations ...'
    puts run('heroku rake db:migrate')
  end
  
  task :check_migrations do
    local_version = run('rails runner "puts ActiveRecord::Migrator.current_version"')
    remote_version = run('heroku console ActiveRecord::Migrator.current_version')
    if remote_version >= local_version
      puts 'Migrations up to date.'
    else
      raise "Please run migrations before deploying"
    end
  end
  
  task :off do
    puts 'Putting the app into maintenance mode ...'
    puts run('heroku maintenance:on')
  end
  
  task :on do
    puts 'Taking the app out of maintenance mode ...'
    puts run('heroku maintenance:off')
  end

  task :push_previous do
    previous_release = PREVIOUS
    if previous_release
      puts "Pushing '#{previous_release}' to Heroku master ..."
      puts run("git push heroku +#{previous_release}:master -f")

      puts 'All done!'
    else
      puts "No release tags found - can't roll back!"
    end
  end
end