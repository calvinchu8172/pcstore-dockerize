worker_processes 1
preload_app true

listen '/tmp/unicorn/unicorn.pcstore.sock' # sock 檔名可依照 app 需求設定

stderr_path 'log/unicorn.error.log'
stdout_path 'log/unicorn.log'

pid "tmp/pids/unicorn.pid"

rails_env = ENV['RAILS_ENV'] || 'production'

# before/after fork 可自行擴充

before_fork do |server, worker|
end

after_fork do |server, worker|
end