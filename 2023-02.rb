LIMITS = {r: 12, g: 13, b: 14}
data = File.read("2023-02.txt").split("\n")

transformed_data = data.
  map do |line|
    [ line.
        scan(/\d+/).
        first.
        to_i,
      line.
        split(":").
        last.
        split(";").
        map do
          _1.
            scan(/\d+ \w/).
            map(&:split).
            map(&:reverse).
            to_h.
            transform_keys(&:to_sym).
            transform_values(&:to_i)
        end
    ]
  end.to_h

def process_part_1(data)
  data.
    filter_map do |round_n, round_d|
      round_n if round_d.all? do |grab|
        LIMITS.all? { |clr, lim| grab[clr].to_i <= lim }
      end
    end.sum
end

def process_part_2(data)
  data.
    map do |_, round_d|
      LIMITS.keys.
        map do |clr|
          round_d.
            filter_map { |grab| grab[clr] }.max
        end.compact.reduce(&:*)
    end.sum
end

puts process_part_1(transformed_data)
puts process_part_2(transformed_data)
