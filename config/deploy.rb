require "bundler/capistrano"
 
# General
set :application, "profoundInstallations"
set :domain, "198.211.124.44"
# set :user, "deploy"
# set :runner, "deploy"
set :use_sudo, false
set :deploy_to, "/var/www/#{application}"
set :repository_cache, "#{application}_cache"
set :environment, "production"
 
# Roles
role :web, domain
role :app, domain
role :db, domain, :primary => true
 
# GIT
set :repository, "git@github.com:SeanHolden/profoundInstallations.git"
set :branch, "master"
set :keep_releases, 3
set :deploy_via, :remote_cache
set :scm, :git
 
# SSH
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:paranoid] = true # comment out if it gives you trouble. newest net/ssh needs this set.
 
######## Callbacks - No More Config ########
after 'deploy:symlink', 'deploy:cleanup' # makes sure there's only 3 deployments, deletes the extras

# Custom Tasks
namespace :deploy do
  task(:start) {}
  task(:stop) {}
 
  desc "Restart Application"
  task :restart, :roles => :web, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end