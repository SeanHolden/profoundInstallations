require 'bundler/capistrano'

set :application, "profoundInstallations"
set :scm, :git
set :use_sudo, false
set :repository, "git@github.com:SeanHolden/#{application}.git"
set :user, "deploy"
server "198.211.124.44", :app, :web, :db, :primary => true
set :deploy_to, "/home/deploy/apps/#{application}"
# set :deploy_via, :remote_cache
set :keep_releases, 3

# SSH
ssh_options[:forward_agent] = true

# 'cap deploy:tail' to tail logs
desc "tail log files"
task :tail, :roles => :app do
  run "tail -f #{shared_path}/log/#{rails_env}.log" do |channel, stream, data|
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end

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