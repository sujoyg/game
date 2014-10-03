require File.expand_path("../../application", __FILE__)
require "capistrano/helpers"

$stage = ENV["STAGE"] || "development"
$globals = Globals.read File.read(File.join Rails.root, "config/globals.yml"), $stage
$config = $globals.override File.read(File.expand_path "../site/config.yml", __FILE__)

before "deploy:starting", "setup" do
  unless $config.to_hash.include?('deployment')
    STDERR.puts "Site deployment is not available for #{$stage}"
    exit(1)
  end

  set :application, $config.application.parameterize
  set :branch, "master"
  set :default_environment, {'USER' => $config.deployment.user}
  set :deploy_to, $config.deployment.dir
  set :rails_env, $stage
  set :repo_url, $config.deployment.repository
  set :scm, :git
  set :scm_verbose, true
  set :use_sudo, false
  set :user, $config.deployment.user

  server $config.deployment.host, user: $config.deployment.user, roles: [:app, :web, :db]
end

desc "Deploy and restart apache."
task :apache do
  config = "namethatcoworker-#{$stage}"
  on roles(:web) do
    os = capture('if [ -f /etc/centos-release ]; then echo centos; elif [ -f /etc/lsb-release ]; then echo ubuntu; fi').strip
    execute "sudo", "apachectl stop || true"
    if os == 'ubuntu'
      copy "site/resources/site", "/etc/apache2/sites-available/#{config}", preprocess: true, config: $config, stage: $stage
      execute :sudo, "a2ensite #{config}"
    elsif os == 'centos'
      copy "site/resources/site", "/etc/httpd/sites-available/#{config}", preprocess: true, config: $config, stage: $stage
      execute :sudo, "ln -sf /etc/httpd/sites-available/#{config} /etc/httpd/sites-enabled/#{config}"
    else
      raise "Operating System #{os} is not supported."
    end
    execute "sudo", "apachectl start"
  end
end

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do
    ;
  end

  task :stop do
    ;
  end

  task :restart do
    on roles(:app) do
      execute "sudo", "touch #{File.join(current_path, "tmp", "restart.txt")}"
    end
  end

  task :branch do
    tag = Capistrano::CLI.ui.ask "Tag to deploy (make sure to push the tag first): [master] "
    set :branch, tag
    default
  end

  after :finishing, :migrate
  after :finishing, :apache
end
