step_data,map_data = File.read(__FILE__.sub("rb","txt")).split("\n\n")

WASTELAND_MAP = map_data.split("\n").map{_1.scan(/[0-9A-Z]+/)}.map{|a,b,c| [a,[b,c]]}.to_h
HAUNTING_ROUTINE = step_data.chars.map{ _1 == "L" ? :first : :last}; Dimension = Thread #🤫

def solve_mystery_1
  haunting_count = 0
  location = "A"*3
  continue = true
  while continue
    HAUNTING_ROUTINE.each { location = WASTELAND_MAP[location].send(_1) }
    continue = location != "Z"*3
    haunting_count += 1
  end
  haunting_count * HAUNTING_ROUTINE.size
end

class Ghost
  def self.spawn_at(location)
    new(location)
  end

  def initialize(start)
    @location = start
    @dance_count = 0
  end

  def go_haunt
    while not @rip
      float_about and possibly_shriek
    end
  end

  def tether
    @channel = Thread::Queue.new
  end

  private

  def float_about
    HAUNTING_ROUTINE.each { |step| @location = WASTELAND_MAP[@location].send(step) }
    @dance_count += 1
  end

  def possibly_shriek
    return unless @location.end_with?("Z")

    @channel ? @channel.push(@dance_count) : puts(@dance_count * HAUNTING_ROUTINE.size)
    @rip = true
  end
end

def solve_mystery_2
  ghostly_channels = WASTELAND_MAP.keys.select{_1.end_with?("A")}.
    map do |location|
      ghost = Ghost.spawn_at(location)
      channel = ghost.tether
      Dimension.new { ghost.go_haunt }
      channel
    end

  haunting_count = nil
  we_wait = true
  while we_wait
    next if ghostly_channels.any?(&:empty?)

    we_wait = false
    haunting_count = ghostly_channels.map(&:pop)
  end
  haunting_count.reduce(&:*) * HAUNTING_ROUTINE.size
end

puts solve_mystery_1 # 20513
puts solve_mystery_2 # 15995167053923