IN_FILE = 'A-small-practice.in'
OUT_FILE = 'A-small-practice.out'

def solve(credit, prices)
  num_items = prices.length

  (0...num_items).each do |i|
    ((i + 1)...num_items).each do |j|
    #  puts "#{i}, #{j}"

      return [i + 1, j + 1] if prices[i] + prices[j] == credit
    end
  end
end

out = open OUT_FILE, 'w'

open IN_FILE do |file|
  lines = file.readlines
  num_tests = lines.shift.to_i

  (1..num_tests).each do |test|
    credit = lines.shift.to_i
    lines.shift.to_i
    prices = lines.shift.split(' ').map {|str| str.to_i}

    out.write "Case ##{test}: #{solve(credit, prices).sort.join(' ')}\n"
  end
end

out.close