data = File.read(__FILE__.sub("rb", "txt")).split("\n")

# count of matches for each card
@clean_data = data.
  map{ _1.split(":").
  last.
  split("|").
  map(&:split)}.
  map{ (_1.first.intersection(_1.last)).size }

def process_part_1
  @clean_data.
    reject(&:zero?).
    map do |matches|
      matches.pred.times.reduce(1){ _1 * 2 }
    end.sum
end

def process_part_2
  @stack_of_cards = 0
  (0...@clean_data.size).
    each{ process_card_at(_1) }
  @stack_of_cards
end

def process_card_at(index)
  @stack_of_cards += 1
  return if @clean_data[index].to_i.zero?

  (index.next..index + @clean_data[index]).
    each{ process_card_at(_1)}
end

puts process_part_1 # 20117
puts process_part_2 # 13768818
