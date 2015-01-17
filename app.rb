require 'sinatra/base'

require_relative 'lib/inorace'

def single_array(size, value)
  array = Array.new(size)
  for r in 0..size-1
    array[r] = 0
  end
  return array
end

def double_array(size, value)
  array = Array.new(size)
  for r in 0..size-1
    array[r] = Array.new(size)
    for rr in 0..size-1
      array[r][rr] = value
    end
  end
  return array
end

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

  get '/bet' do
    @is_bet = true
    runners = 5
    runners = params['runners'].to_i if @params['runners'].to_i > 1

    # 本レースの設定
    @race = Race.new
    @race.set_normal_race(Course.new(64000), runners)

    # 倍率決定のためのレース
    counts = 10000
    rank_counts = double_array(runners, 0)
    first_counts = single_array(runners, 0)
    # result_counts = double_array(runners, 0)
    result_counts2 = double_array(runners, 0)
    for i in 1..counts
      one_race = Race.new
      one_race.set_original_race(@race.get_course, runners, @race.get_runner_speeds, @race.get_runner_stables)
      one_race.run
      ranks = one_race.get_result_ranks
      rank_set = one_race.get_rank_ordered_runner_ids
      for r in 0..runners-1
        rank_counts[r][ranks[r]-1] += 1
      end
      first_counts[rank_set[0]-1] += 1
      # result_counts[rank_set[0]-1][rank_set[1]-1] += 1
      result_counts2[rank_set[0]-1][rank_set[1]-1] += 1
      result_counts2[rank_set[1]-1][rank_set[0]-1] += 1
    end

    @first_odds = single_array(runners, 0)
    @pair_odds = double_array(runners, 0)

    @first_odds.each_with_index do |odds, i|
      @first_odds[i] = counts/(first_counts[i]+1)
    end
    @pair_odds.each_with_index do |c1, i|
      c1.each_with_index do |c2, j|
        @pair_odds[i][j] = counts/(result_counts2[i][j]+1)
      end
    end

    # 本レースの実行
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
