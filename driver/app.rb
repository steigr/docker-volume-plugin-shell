#!/usr/bin/env ruby

require 'sinatra'
require 'json'
require 'open3'

configure {
  set :server, :puma
}

def make_env vars, prefix=nil
  if vars.is_a? Hash
    vars.collect do |i,v|
      make_env(v, [prefix,i].compact.join("_").upcase)
    end   
  elsif vars.is_a? Array
    vars.collect.with_index do |v,i|
      make_env(v, [prefix,i].compact.join("_").upcase)
    end
  else
    "#{prefix.upcase}='#{vars}'"
  end
end

class DockerVolumePluginShell < Sinatra::Base
  post '/*' do
    content_type :json
    status 200
    path = File.basename(request.env["REQUEST_PATH"])
    vars = JSON.parse(env["rack.request.form_vars"]) rescue {}
    vars = make_env(vars,path.split(".",2)[0]).flatten.join(" ")
    puts "#{vars} '/handler/#{path}'"
    return `#{vars} '/handler/#{path}'`.strip
  end
  run! if app_file == $0
end
