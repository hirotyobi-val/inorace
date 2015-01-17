# コース
class Course
  @distance # コース長(Intのwrap)

  def initialize(distance)
    @distance = distance
  end

  attr_reader :distance
end
