set :application, "accelerant"
set :user, "chazzer"
set :admin_runner, "chazzer"
set :port, 30000
#set :repository,  "set your repository location here"
set :deploy_to, "/home/chazzer/public_html/#{application}"
 
default_run_options[:pty] = true
#set :repository,  "git://github.com/chazzerguy/Accelerant.git"
set :repository,  "git@github.com:chazzerguy/Accelerant.git"
 
 
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"
 
# If you aren't using Subversion to manage your source code, specify
# your SCM below:

set :scm, "git"
set :branch, "master"
#ssh_options[:forward_agent] = true
set :user, "chazzer@Accelerant"  # The server's user for deploys
set :scm_passphrase, "At0m1cD0g"  # The deploy user's password
set :deploy_via, :remote_cache
#set :scm_command, "usr/lib/ruby/gems/1.8/gems/git-1.0.5/lib/git/"
 
set :location, "67.23.9.5"
 
role :app, location
role :web, location
role :db,  location, :primary => true
 
namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  desc "Start Application -- not needed for Passenger"
  task :start, :roles => :app do
    #nothing -- need to override default cap start task when using passenger
  end
end

after "deploy:symlink", "deploy:update_crontab"

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end