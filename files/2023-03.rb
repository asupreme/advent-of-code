data = File.read(__FILE__.sub("rb", "txt")).split("\n")

@prepared_data = data.
    map { |line| line.tr(".", " ").gsub(/[^\d\s]/, "*").chars }.
    prepend((" " * data.first.size).chars).
    append((" " * data.first.size).chars).
    map { _1.prepend(" ").append(" ") }

def traverse(lines)
  (1..lines.size-2).map do |i|
    (1..lines[i].size-2).map do |j|
      process_window_for(i,j) if lines[i][j] == "*"
    end
  end.
    map(&:compact).
    reject(&:empty?).
    flatten(1).
    map { _1.map(&:to_i) }
end

def process_window_for(y,x)
  (-1..1).map do
    process_line(@prepared_data[y + _1][x - 3, 7])
  end.flatten
end

def process_line(line)
  case line[2,3].map { _1.scan(/\d/).any? }       # ..[...]..
  when [true, true, true], [false, true, false]
    line[2,3].join.scan(/\d+/)                    # ..[>...<]..
  when [true, true, false], [true, false, false]
    [line[0,4].join.scan(/\d+/).last]             # [....<]...
  when [false, true, true], [false, false, true]
    [line[3,4].join.scan(/\d+/).first]            # ...[>....]
  when [true, false, true]
    [line[0,3].join.scan(/\d+/).last,             # [...<].[>...]
      line[4,3].join.scan(/\d+/).first]
  else
    []
  end
end

def process_part_1(data)
  traverse(@prepared_data).
    map { _1.reduce(&:+) }.
    sum
end

def process_part_2(data)
  traverse(@prepared_data).
    reject{ _1.size != 2}.
    map { _1.reduce(&:*) }.
    sum
end

puts process_part_1(data) # 527364
puts process_part_2(data) # 79026871
