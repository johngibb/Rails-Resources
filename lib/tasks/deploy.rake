PREVIOUS = ".previous-deploy"

task :deploy => ['deploy:record', 'deploy:push', 'deploy:restart']

namespace :deploy do
  task :migrations => [:push, :off, :migrate, :restart, :on, :record]
  task :rollback => [:off, :push_previous, :restart, :on]

  task :push do
    current_branch = `git branch 2> /dev/null | sed -n 's/^\* \(.*\)$/(\1)/p'`.chomp
    puts 'Deploying site to Heroku ...'
    puts `git push heroku #{current_branch}:master -f`
  end
  
  task :restart do
    puts 'Restarting app servers ...'
    puts `heroku restart`
  end
  
  task :record do
    current_release = `git log remotes/heroku/master --oneline | head -n 1 | cut -d ' ' -f 1`.chomp
    File.open(PREVIOUS, "w") { |f| f.puts current_release }
  end
  
  task :migrate do
    puts 'Running database migrations ...'
    puts `heroku rake db:migrate`
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
    previous_release = File.read(PREVIOUS)
    current_branch = `git branch 2> /dev/null | sed -n 's/^\* \(.*\)$/(\1)/p'`.chomp
    
    if previous_release
      branch = "deploy-#{previous_release}"
      puts "Rolling back to '#{previous_release}' ..."
      
      puts "Checking out '#{previous_release}' in a new branch on local git repo ..."
      puts `git checkout -b #{branch} #{previous_release}`
      
      puts "Pushing '#{previous_release}' to Heroku master ..."
      puts `git push heroku +#{branch}:master --force`
      
      puts 'Check out master'
      puts `git checkout #{current_branch}`
      
      puts 'Removing deploy branch'
      puts `git branch -d #{branch}`
      
      puts 'Deleting previous file'
      File.delete(PREVIOUS)

      puts 'All done!'
    else
      puts "No release tags found - can't roll back!"
    end
  end
end