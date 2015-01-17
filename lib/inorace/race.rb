# レース
class Race
  @course # コース(Course)
  @runners # 走者(Runner)

  @is_end # レース終了したかどうか(Bool)

  @turns # ターン毎の情報(Turn[])

  # ターン毎の情報
  class Turn
    @positions # 各走者の位置(Int[])
    @ranks # 各走者の順位(Int[])

    def initialize
      @positions = []
      @ranks = []
    end

    attr_accessor :positions, :ranks
  end

  # レース設定
  def set_normal_race(course, n_runner)
    @course = course

    @runners = []
    for i in 0..n_runner-1
      # @runners << Runner.create_random_runner(i+1)
      @runners << create_random_runner(i+1)
    end
    @is_end = false
  end

  def get_course
    @course
  end

  def get_runners
    @runners
  end

  def get_turns
    @turns
  end

  def get_turn_positions
    result = []
    @turns.each do |turn|
      result << turn.positions
    end
    return result
  end

  def get_turn_ranks
    result = []
    @turns.each do |turn|
      result << turn.ranks
    end
    return result
  end

  def get_result_positions
    return get_turn_positions.last
  end

  def get_result_ranks
    return get_turn_ranks.last
  end

  def get_rank_ordered_runners
    return @runners.sort{|r1, r2| r2.position <=> r1.position}
  end

  def get_rank_ordered_runner_ids
    result = []
    get_rank_ordered_runners.each do |runner|
      result << runner.id
    end
    return result
  end

  def puts_runners_info
    # レース設定表示
    puts "distance:#{@course.distance}"
    @runners.each do |runner|
      puts "#{runner.id}(speed:#{runner.speed}, stable:#{runner.stable})"
    end
    puts
  end

  # レース実行
  def run
    @turns = []
    # ターン実行
    while !@is_end
      # sleep(0.2)
      turn = Turn.new
      # 走る
      @runners.each do |runner|
        runner.normal_run
        turn.positions << runner.position
      end
      # 順位
      @runners.sort{|r1, r2| r2.position <=> r1.position}.each_with_index do |runner, i|
        runner.rank = i+1
      end
      @runners.each do |runner|
        turn.ranks << runner.rank
      end
      # 出力
      @runners.each do |runner|
        # print "#{runner.id}(speed:#{runner.speed}, stable:#{runner.stable})"
        # print "#{runner.rank}位"
        # print "#{format("%4d", runner.position)}"
        # for i in 1..((@course.distance - runner.position + 9)/10)
        #   print " "
        # end
        # puts "#{[runner.id]}"
        # 誰かがゴールについていたら終了フラグ
        @is_end = true if runner.position >= @course.distance
      end
      @turns << turn
      # puts
    end
    # p "#{@runners.sort{|r1, r2| r2.position <=> r1.position}[0].id}-#{@runners.sort{|r1, r2| r2.position <=> r1.position}[1].id}"
    # p get_turn_positions
    # p get_turn_ranks
    # p get_result_positions
    # p get_result_ranks
    # p get_rank_ordered_runners
    # p get_rank_ordered_runner_ids
  end
end
