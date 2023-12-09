def step_in(arr)
  return [0] if arr.all?(&:zero?)

  lvl = arr[1..].map.with_index { _1-arr[_2] }
  extrapolate(lvl)
end

def extrapolate(lvl)
  trmnls = step_in(lvl)
  [lvl.first - trmnls.first, lvl.last + trmnls.last]
end

r = File.
  read(__FILE__.sub("rb", "txt")).
  split("\n").
  map(&:split).
  map { extrapolate(_1.map(&:to_i)) }

puts r.sum(&:last) # 1904165718
puts r.sum(&:first) # 964
