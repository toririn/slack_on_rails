set :enviroment, :development
set :output, {error: 'log/cron_error.log', standard: 'log/cron_std.log'}

every 1.days, at: '4:00 am' do
  rake 'otacks:update'
end

every 1.days, at: '4:10 am' do
  rake 'user_images:update'
end

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

#every 1.day, at: '1:06' do
#  rake 'users:update'
#end
