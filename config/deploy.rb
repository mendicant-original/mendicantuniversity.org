require 'bundler/capistrano'

set :application, "mendicantuniversity.org"
set :repository,  "git://github.com/mendicant-university/mendicantuniversity.org.git"

set :scm, :git
set :deploy_to, "/var/rapp/#{application}"

set :user, "git"
set :use_sudo, false

set :deploy_via, :remote_cache

set :branch, "master"
server "mendicantuniversity.org", :app, :web, :db, :primary => true

namespace :deploy do
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after "deploy", 'deploy:cleanup'