require_relative 'inorace/runner'
require_relative 'inorace/course'
require_relative 'inorace/race'

def one_race_run(runners, speeds, stables)
  @race = Race.new
  @race.set_original_race(Course.new(64000), runners, speeds, stables)
  @race.run

  return @race
end

def single_array(size, value)
  array = Array(size)
  for r in 0..size-1
    array[r] = 0
  end
  return array
end

def double_array(size, value)
  array = Array(size)
  for r in 0..size-1
    array[r] = Array(size)
    for rr in 0..size-1
      array[r][rr] = value
    end
  end
  return array
end

def main
  runners = 5
  # speeds = [99, 100, 100, 101, 101]
  # stables = [31, 24, 17, 10, 3]
  # speeds = [299, 300, 300, 301, 300]
  # stables = [45, 34, 5, 29, 5]
  speeds = [798, 799, 800, 801, 802]
  stables = [60, 20, 60, 20, 60]
  p speeds
  p stables

  counts = 10000

  rank_counts = double_array(runners, 0)
  first_counts = single_array(runners, 0)
  result_counts = double_array(runners, 0)
  result_counts2 = double_array(runners, 0)

  for i in 1..counts
    race = one_race_run(runners, speeds, stables)
    ranks = race.get_result_ranks
    rank_set = race.get_rank_ordered_runner_ids
    # p ranks
    # p rank_set
    for r in 0..runners-1
      rank_counts[r][ranks[r]-1] += 1
    end
    first_counts[rank_set[0]-1] += 1
    result_counts[rank_set[0]-1][rank_set[1]-1] += 1
    result_counts2[rank_set[0]-1][rank_set[1]-1] += 1
    result_counts2[rank_set[1]-1][rank_set[0]-1] += 1
  end

  p rank_counts
  p first_counts
  first_counts.each do |c0|
    print "x#{counts/(c0+1)} "
  end
  puts
  p result_counts
  result_counts.each do |c1|
    c1.each do |c2|
      print "x#{counts/(c2+1)} "
    end
    puts
  end
  p result_counts2
  result_counts2.each do |c1|
    c1.each do |c2|
      print "x#{counts/(c2+1)} "
    end
    puts
  end
end

main
