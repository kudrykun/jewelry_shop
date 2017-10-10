role :app, %w(hosting_jeweller046@cobalt.locum.ru)
role :web, %w(hosting_jeweller046@cobalt.locum.ru)
role :db, %w(hosting_jeweller046@cobalt.locum.ru)

set :ssh_options, forward_agent: true
set :rails_env, :production
