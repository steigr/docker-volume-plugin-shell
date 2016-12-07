bind "unix:///var/run/docker/plugins/#{ENV["DRIVER_NAME"].downcase}/#{ENV["DRIVER_NAME"].downcase}.sock"
pidfile "/var/run/docker/plugins/#{ENV["DRIVER_NAME"].downcase}/pid"
state_path "/var/run/docker/plugins/#{ENV["DRIVER_NAME"].downcase}/state"
rackup "#{Dir.getwd}/config.ru"

threads 2, 2

activate_control_app