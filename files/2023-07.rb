# shameless_mode: true

data = File.read(__FILE__.sub("rb","txt")).split("\n")

data = data.map(&:split).map{|f,l| [f.chars, l.to_i]}

TYPES = {
  [5] => "a",
  [4,1] => "b",
  [3,2] => "c",
  [3,1,1] => "d",
  [2,2,1] => "e",
  [2,1,1,1] => "f",
  [1,1,1,1,1] => "g",
}

CARD_RANKS = "AKQJT98765432".chars.zip("abcdefghijklm".chars).to_h

def part_1(data)
  rankable = {}
  data.each do |hand|
    rank = hand.first.tally.values.sort.reverse
    hand_rank = TYPES[rank].dup
    hand.first.each{|card| hand_rank << CARD_RANKS[card] }
    rankable[hand_rank] = hand.last
  end

  rankable.keys.sort.reverse.map.with_index do |hand, i|
    rankable[hand] * (i+1)
  end.sum
end

def part_2(data)
  new_ranks = CARD_RANKS.dup
  new_ranks["J"] = "n"
  rankable = {}
  data.each do |hand|
    rank = hand.first.tally.values.sort.reverse
    jokers = hand.first.count("J")
    unless jokers.zero?
      rank = case rank
        when [5] then [5]
        when [4,1] then [5]
        when [3,2] then [5]
        when [3,1,1] then [4,1]
        when [2,2,1]
          case jokers
          when 2
            [4,1]
          else
            [3,2]
          end
        when [2,1,1,1] then [3,1,1]
        when [1,1,1,1,1] then [2,1,1,1]
        end
    end

    hand_rank = TYPES[rank].dup
    hand.first.each{|card| hand_rank << new_ranks[card] }
    rankable[hand_rank] = hand.last
  end

  rankable.keys.sort.reverse.map.with_index do |hand, i|
    rankable[hand] * (i+1)
  end.sum
end

puts part_1(data) # 248836197
puts part_2(data) # 251195607
