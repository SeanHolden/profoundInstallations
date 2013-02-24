require 'bundler/capistrano'

set :application, "profoundInstallations"
set :scm, :git
set :repository, "git@github.com:SeanHolden/#{application}.git"
set :user, "root"
server "198.211.124.44", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/#{application}"

# SSH
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:paranoid] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  
# If you are using Passenger mod_rails do this (restart nginx):
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

# Create the db's in cold deploy
  desc "cold deploy: update, create_db, start"
  task :cold do # Overriding the default deploy:cold
    update
    create_db # My own step
    start
  end

#Add the below to copy a config yml from shared dir.
  desc "Copy the config.yml file into the latest release"
  task :copy_in_config_yml do
      run "cp #{shared_path}/config/config.yml #{latest_release}/config/"
  end

#Create DBs
  desc "Create the databases"
  task :create_db, :roles => :db do
    run "cd #{current_path};bundle exec rake db:create RAILS_ENV=#{rails_env};bundle exec rake db:migrate RAILS_ENV=#{rails_env}"
  end

end

after "deploy:update_code", "deploy:copy_in_config_yml"
before "deploy:migrate", "deploy:copy_in_config_yml"
before "deploy:assets:precompile", "deploy:copy_in_config_yml"