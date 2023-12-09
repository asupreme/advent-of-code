def stp(arr); arr.all?(&:zero?) ? [0] : ext(arr[1..].map.with_index { _1-arr[_2] }); end
def ext(lvl); exts = stp(lvl); [lvl.first-exts.first, lvl.last+exts.last]; end
puts File.read(__FILE__.sub("rb", "txt")).split("\n").
  reduce([0,0]) { _1.zip(ext(_2.split.map(&:to_i))).map(&:sum) }.reverse # 1904165718,964
