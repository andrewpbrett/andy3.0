set :application, "andy"

set :user, "deployer"
set :domain, "184.106.227.114"
set :deploy_to, "/var/www/#{application}"
set :use_sudo, true

set :scm, :git
set :repository,  "git@github.com:andrewpbrett/Andy-3.0.git"
set :branch, 'master'

role :web, domain                         
role :app, domain                         
role :db,  domain, :primary => true

ssh_options[:forward_agent] = true

default_run_options[:pty] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  desc "Change owner"
  task :chown, :roles => :app do
    run "chown deployer:apps -R #{latest_release}"
  end
  desc "Restart appliction"  
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end 
  desc "Copy database.yml"
  task :dbconfig do
    run "cp #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end
end

after "deploy:update_code", "deploy:chown"
after "deploy", "deploy:dbconfig"