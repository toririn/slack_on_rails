app_path = "#{File.expand_path("../..", __FILE__)}"

directory app_path

environment 'production'

daemonize true

state_path "#{app_path}/tmp/pids/puma.state"

stdout_redirect "#{app_path}/log/puma.stdout.log", "#{app_path}/log/puma.stderr.log"

bind "unix://#{app_path}/tmp/sockets/puma.sock"
