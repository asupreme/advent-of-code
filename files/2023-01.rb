data = File.read(__FILE__.sub("rb", "txt")).split("\n")

def process_step_one(data)
  data.map { _1.scan(/\d/).values_at(0, -1).join.to_i }.sum
end

WORD_SUBS = %w[one two three four five six seven eight nine].map.with_index do |w, i|
  [w] << [w.chars.first, i+1, w.chars.last].join
end

def process_step_two(data)
  data.map do |line|
    WORD_SUBS.
      inject(line.dup) { |l, subs| l.gsub(*subs) }.
      scan(/\d/).
      values_at(0, -1).
      join
  end.
    map { _1 * (3 - _1.length) }.
    sum(&:to_i)
end

puts process_step_one(data) # 54561
puts process_step_two(data) # 54076
