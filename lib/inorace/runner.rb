# 走者
class Runner
  @id # 走者番号
  @speed # 初期スピード(Intのwrap)
  # @stamina # 初期スタミナ(Intのwarp?)
  @stable # 初期安定感(Intのwrap?)
  # @spirit # 初期根性(Intのwarp?)

  @position　# 現在位置(Intのwrap)
  @rank # 現在順位(int)

  def initialize(id, speed, stable)
    @id = id
    @speed = speed
    @stable = stable
    @position = 0
  end

  attr_reader :id, :speed, :stable, :position
  attr_accessor :rank

  def normal_run
    @position += @speed + (rand(@stable*2) - @stable + 1)
  end

  def create_random_runner(id)
    # hiddenのsource
    # スピード49～51, 安定感1～5
    Runner.new(id, 49 + rand(3), 1 + rand(5))
  end

  # public_class_method :new, :create_random_runner
end

def create_random_runner(id)
  # hiddenのsource
  Runner.new(id, 49 + rand(3), 1 + rand(5))
end
