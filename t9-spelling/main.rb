IN_FILE = 'C-large-practice.in'
OUT_FILE = 'C-large-practice.out'

# IN_FILE = 'sample.in'
# OUT_FILE = 'sample.out'

KEYPAD = {
  'abc' =>  '2',
  'def' =>  '3',
  'ghi' =>  '4',
  'jkl' =>  '5',
  'mno' =>  '6',
  'pqrs' => '7',
  'tuv' =>  '8',
  'wxyz' => '9'
}

CHARS_TO_PRESSES = {
  ' ' => '0'
}

KEYPAD.each do |k, v|
  k.split('').each_with_index do |letter, i|
    CHARS_TO_PRESSES[letter] = v * (i + 1)
  end
end

def solve msg
  presses = ''
  last_char = nil

  msg.chars do |c|
    presses << ' ' if !last_char.nil? and CHARS_TO_PRESSES[c][0] == CHARS_TO_PRESSES[last_char][0]
    presses << CHARS_TO_PRESSES[c]
    last_char = c
  end

  presses
end

out = open OUT_FILE, 'w'

open IN_FILE do |file|
  lines = file.readlines
  num_tests = lines.shift.to_i

  (1..num_tests).each do |test|
    msg = lines.shift.chomp "\n"
    line = "Case ##{test}: #{solve(msg)}\n"

    puts line
    out.write line
  end
end

out.close