x=->(i,j=i==[0]?0:x.(i.each_cons(2).map{_2-_1})){i[0]-j}
l=File.readlines("d").map{_1.split.map(&:to_i)}
p l.sum{x.(_1)},l.sum{x.(_1.reverse)}