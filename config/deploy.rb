# encoding: utf-8
# config valid only for Capistrano 3
lock '3.9.1'

# Project configuration options
# ------------------------------

set :application,    'jewelry-store'
set :login,          'jeweller046'
set :user,           'hosting_jeweller046'

set :deploy_to,      "/home/#{fetch(:user)}/projects/#{fetch(:application)}"
set :unicorn_conf,   "/etc/unicorn/#{fetch(:application)}.#{fetch(:login)}.rb"
set :unicorn_pid,    "/var/run/unicorn/#{fetch(:user)}/" \
                     "#{fetch(:application)}.#{fetch(:login)}.pid"
set :bundle_without, %w{development test}.join(' ')             # this is default
set :use_sudo,       false
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')
set :linked_files, fetch(:linked_files, []).push('config/initializers/paperclip.rb')
set :linked_files, fetch(:linked_files, []).push('config/environments/production.rb')
set :repo_url,       "git@github.com:kudrykun/jewelry_shop.git"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :format, :pretty
set :pty, true

# Change the verbosity level
set :log_level, :info

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w(log tmp/cache tmp/pids vendor/bundle public/system)

# Default value for keep_releases is 5
# set :keep_releases, 5

# Configure RVM
set :rvm_ruby_version, '2.4'

# You unlikely have to change below this line
# -----------------------------------------------------------------------------

# Configure RVM
set :rake,            "rvm use #{fetch(:rvm_ruby_version)} do bundle exec rake"
set :bundle_cmd,      "rvm use #{fetch(:rvm_ruby_version)} do bundle"

set :assets_roles, [:web, :app]

set :unicorn_start_cmd,
    "(cd #{fetch(:deploy_to)}/current; rvm use #{fetch(:rvm_ruby_version)} " \
    "do bundle exec unicorn_rails -Dc #{fetch(:unicorn_conf)})"

=begin
namespace :db do
  task :copy_configuration do
    run "cp #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end
=end

# - for unicorn - #
namespace :deploy do

  desc 'Start application'
  task :start do
    on roles(:app) do
      execute unicorn_start_cmd
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:app) do
      execute "[ -f #{fetch(:unicorn_pid)} ] && " \
              "kill -QUIT `cat #{fetch(:unicorn_pid)}`"
    end
  end

  after :publishing, :restart

  desc 'Restart Application'
  task :restart do
    on roles(:app) do
      execute "[ -f #{fetch(:unicorn_pid)} ] && " \
              "kill -USR2 `cat #{fetch(:unicorn_pid)}` || " \
              "#{fetch(:unicorn_start_cmd)}"
    end
  end
end

