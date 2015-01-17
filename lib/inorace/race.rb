# レース
class Race
  @course # コース(Course)
  @runners # 走者(Runner)

  @is_end # レース終了したかどうか(Bool)

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
    # ターン実行
    while !@is_end
      # sleep(0.2)
      # 走る
      @runners.each do |runner|
        runner.normal_run
      end
      # 順位
      @runners.sort{|r1, r2| r2.position <=> r1.position}.each_with_index do |runner, i|
        runner.rank = i+1
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
      # puts
    end
    # p "#{@runners.sort{|r1, r2| r2.position <=> r1.position}[0].id}-#{@runners.sort{|r1, r2| r2.position <=> r1.position}[1].id}"
  end
end
