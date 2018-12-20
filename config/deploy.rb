server '3.17.139.234', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:akankshajain9290/advertisement_portal.git'
set :application,     'advertisement_portal'
set :user,            'ubuntu'

set :stage,           :production
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}_puma.sock"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }


set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs,  %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :local_config_path, '/Users/akanksha//Documents/Akanksha/advertisement_portal/config'

namespace :config do
  desc 'Setup configuration'
  task :upload do |t|
    run_locally do
      on roles(:all) do
        ['database.yml', 'secrets.yml'].each do |file|
          upload!("#{fetch(:local_config_path)}/#{file}" , "#{shared_path}/config")
        end
      end
    end
  end
  before 'deploy:check:linked_files', 'config:upload'
end
