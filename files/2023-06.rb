data = File.read(__FILE__.sub("rb", "txt")).split("\n")

# part 1 — 1624896
TrueClass.define_method(:to_i){1}; FalseClass.define_method(:to_i){0}
l1,l2 = *data.map { _1.scan(/\d+/).map(&:to_i) }
puts(l1.zip(l2).map{|t,d| t.times.map{_1}[1..].reduce(0){|r,h| r+=((t-h)*h > d).to_i}}.compact.reduce(&:*))

# part2 — 32583852
t,d = data.map { |l| l.scan(/\d+/).join.to_i }
puts(t.times.map{_1}[1..].reduce(0){|res,hodl| (t-hodl)*hodl > d ? res+=1 : res})
