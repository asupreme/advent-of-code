def step_in(arr)
    return [0,0] if arr.all?(&:zero?)
  
    lvl = arr[1..].map.with_index{_1-arr[_2]}
    extrapolate(lvl,step_in(lvl))
  end
  
  def extrapolate(lvl,trmnls)
    [lvl.first - trmnls.first, lvl.last + trmnls.last]
  end
  
  r = File.
    read(__FILE__.sub("rb","txt")).
    split("\n").
    map(&:split).
    map{_1.map(&:to_i)}.
    map{extrapolate(_1,step_in(_1))}
  
  puts r.map(&:last).sum # 1904165718
  puts r.map(&:first).sum # 964
  