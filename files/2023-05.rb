data = File.read(__FILE__.sub("rb", "txt")).split("\n\n")

# this is really only part 2

@parsed_data = {}
data.each do |block|
  block.split("\n").each.with_index do |line, i|
    if i.zero?
      @key = line.split.first.tr(":", "")
      @parsed_data[@key] = []
      next
    end

    @parsed_data[@key] << line.split.map(&:to_i)
  end
end

@seeds = @parsed_data["seeds"].map { |seed,range| (seed...seed+range) }

# merge overlapping seed ranges
continue = true
while continue do
  initial = @seeds.size
  @seeds.sort_by(&:begin).each.with_index do |s,i|
    next if i == 0

    f,l = @seeds[i-1],s
    if f.begin <= l.end && l.begin <= f.end
      @seeds[i] = ([f.begin,l.begin].min...[f.end,l.end].max)
      @seeds[i-1] = nil
    end
  end
  @seeds = @seeds.compact
  continue = initial > @seeds.size
end

@mappings = {}
mapping_names = @parsed_data.keys[1..]
mapping_names.each do |mapping_name|
  @mappings[mapping_name] = @parsed_data[mapping_name].
    map { |to,from,range| [(from...from+range),to] }.
    sort_by! { _1.first.begin }
end

thread_queue = Thread::Queue.new
threads = @seeds.map.with_index do |seed_range, thread|
  Thread.new do
    res = Float::INFINITY # ∞
    prev_idx = 0
    seed_range.each do |seed|
      temp_res = mapping_names.reduce(seed) do |starting_num,mapping_name|
          mapped_num = @mappings[mapping_name].find.with_index do |mapping, idx|
            if mapping_name == mapping_names.first
            end
            idx >= prev_idx && mapping.first.include?(starting_num)
          end
          next(starting_num) unless mapped_num

          mapped_num.last + (starting_num - mapped_num.first.begin)
        end
      if temp_res < res
        res = temp_res
        thread_queue.push(res)
        puts "\nthread #{thread} --- seed #{seed} --- res #{res} --- #{Time.now}"
      end
    end
  end
end

best_result = Float::INFINITY # and beyond
while threads.any?(&:alive?) do
  sleep(2)
  if thread_queue.empty?
    print "."
  else
    new_val = thread_queue.pop
    best_result = best_result < new_val ? best_result : new_val
    puts "best is #{best_result}"
  end
end

while !thread_queue.empty?
  new_val = thread_queue.pop
  best_result = best_result < new_val ? best_result : new_val
  puts "best is #{best_result}"
end
