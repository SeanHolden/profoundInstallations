# require 'bundler/capistrano'
# require "rvm/capistrano"

set :application, "profoundInstallations"
set :repository,  "https://github.com/SeanHolden/profoundInstallations.git"

set :scm, :git
server "212.48.68.67", :web, :app, :db, :primary => true
# ssh_options[:keys] = "~/.pem"

set :deploy_to, "/home/sean/webapps/#{application}" 

set :user, "sean" 
# set :group, "sudo"
set :use_sudo, false

# The below allows copy (no need for ssh keys, etc on the remote server)
set :deploy_via, :copy
set :copy_strategy, :export

# assets precompile
set :normalize_asset_timestamps, false


# if you want to clean up old releases on each deploy do this:
after "deploy:restart", "deploy:cleanup"

# using Passenger mod_rails do this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end