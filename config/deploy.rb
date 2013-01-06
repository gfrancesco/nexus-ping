set :application, "nexus-ping"
set :repository,  "git@github.com:gfrancesco/nexus-ping.git"
set :scm, :git
set :user, 'deployer'

set :rvm_ruby_string, '1.9.3'

set :deploy_to, "/home/fra/www/app/#{application}"
set :use_sudo, false

set :normalize_asset_timestamps, false

server "kiwit.linode", :app, :web, :db, :primary => true

set :rbenv_root, "/usr/local/rbenv"
set :default_environment, {
  'PATH' => "#{rbenv_root}/shims:#{rbenv_root}/bin:$PATH"
}

namespace :cron do
  desc "Set system cron with config/cron file."
  task :set do
    run "crontab #{current_path}/config/cron"
  end

  desc "Removes user cronjobs."
  task :remove do
    run "crontab -r"
  end
end

namespace :deploy do
  desc "Copy user specific conf."
  task :conf_copy do
    top.upload "config/user_pref.yml", "#{current_path}/config/user_pref.yml"
    top.upload "config/cron", "#{current_path}/config/cron"
  end
end

namespace :bundle do
  desc "Clean outdated GEMs."
  task :clean do
    run "cd #{current_path} && bundle clean"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:update", "deploy:cleanup"
after "deploy:update", "deploy:conf_copy"

require 'bundler/capistrano'
