require 'sinatra/base'

require_relative 'lib/inorace'

class MyApp < Sinatra::Base

  get '/' do
    @race = Race.new
    @race.set_normal_race(Course.new(1000), 5)
    erb :debug_race_info
  end
end
