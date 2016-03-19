# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :enviroment, :development
set :output, {error: 'log/cron_error.log', standard: 'log/cron_std.log'}

every 1.days, at: '4:20 am' do
  rake 'users:update'
end

every 1.days, at: '4:30 am' do
  rake 'channels:update'
end

every 1.days, at: '1:00 pm' do
  rake 'users:update'
end

every 1.days, at: '1:10 pm' do
  rake 'channels:update'
end

every 1.days, at: '4:10 am' do
  rake 'user_images:update'
end

every 1.days, at: '4:00 am' do
  rake 'otacks:update'
end

#every 1.day, at: '1:06' do
#  rake 'users:update'
#end
