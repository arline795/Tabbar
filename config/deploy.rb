# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'taddar'
set :repo_url, 'git@github.com:joeyk16/yorlook.git'
set :user, 'deploy'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :deploy_to, '/home/deploy/taddar'

# Default value for :format is :airbrussh.
set :format, :pretty

set :ssh_options,     forward_agent: false, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub)

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, false

set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/application.yml'
# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 2

namespace :deploy do
  after :restart, :restart_passenger do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :touch, 'tmp/restart.txt'
      end
    end
  end
  after :finishing, 'deploy:restart_passenger'
end
