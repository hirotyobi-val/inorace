require_relative 'inorace/runner'
require_relative 'inorace/course'
require_relative 'inorace/race'

def main
  n_runner = ARGV[0].to_i if ARGV[0]
  n_runner = 5 if !ARGV[0]

  race = Race.new
  race.set_normal_race(Course.new(1000), n_runner)
  race.puts_runners_info

  # getsとARGVは併用できない
  STDIN.gets

  race.run
end

main
