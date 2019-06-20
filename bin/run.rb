require_relative '../config/environment'

system('rake db:migrate')

get_input
