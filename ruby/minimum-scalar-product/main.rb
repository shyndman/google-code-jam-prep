DEBUG = false
IN_FILE = 'A-large-practice.in'
OUT_FILE = 'A-large-practice.out'

def solve(vector_length, v1, v2)
  v1.sort!
  v2.sort!

  product = 0
  (0...vector_length).each do |i|
    product += v1[i] * v2[-(i + 1)]
  end

  product
end

out = open OUT_FILE, 'w' unless DEBUG

open IN_FILE do |file|
  lines = file.readlines
  num_tests = lines.shift.to_i

  (1..num_tests).each do |test|
    vector_length = lines.shift.to_i
    v1 = lines.shift.split(' ').map {|e| e.to_i}
    v2 = lines.shift.split(' ').map {|e| e.to_i}

    puts line = "Case ##{test}: #{solve(vector_length, v1, v2)}\n"
    out.write line unless DEBUG
  end
end

out.close unless DEBUG