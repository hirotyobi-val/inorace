require 'sinatra/base'

require_relative 'lib/inorace'

class MyApp < Sinatra::Base

  get '/' do
    @race = Race.new
    @race.set_normal_race(Course.new(64000), 5)
    @race.run
    erb :debug_race_info
  end

  get '/race' do
    runners = 5
    runners = params['runners'].to_i if @params['runners'].to_i > 1

    @race = Race.new
    @race.set_normal_race(Course.new(64000), runners)
    @race.run
    erb :debug_race_info
  end

  # TODO : 外からパラメータで具体的な値を指定できるようにする
  get '/original' do
    runners = 5
    runners = params['runners'].to_i if @params['runners'].to_i > 1

    @race = Race.new
    @race.set_original_race(Course.new(64000), runners, [798, 799, 800, 801, 802], [60, 48, 36, 24, 12])
    @race.run
    erb :debug_race_info    
  end
end
