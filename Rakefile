require_relative 'config/environment'
require 'sinatra/activerecord/rake'


desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

task :run do
  login = UserLogin.new
  login.run
end
