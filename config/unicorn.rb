rails_root = File.expand_path('../../', __FILE__)
application_name = "slack_on_rails"
# unicornのsockファイルやpidファイルを置く場所のパス
unicorn_path = "/var/run/unicorn/"
ENV['BUNDLE_GEMFILE'] = rails_root + "/Gemfile"

worker_processes = 2
working_directory rails_root

timeout 30

listen "#{unicorn_path}unicorn_#{application_name}.sock"
# とりあえず動かしたいだけなら 8080 で動かせれる。
#listen 8080
pid "#{unicorn_path}unicorn_#{application_name}.pid"

stderr_path File.expand_path('../../log/unicorn_stderr.log', __FILE__)
stdout_path File.expand_path('../../log/unicorn_stdout.log', __FILE__)

preload_app true
