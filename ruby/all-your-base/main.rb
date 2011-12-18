#
# Constants
#

DEBUG = false
IN_FILES = Dir.glob('*.in')
OUT_FILES = IN_FILES.map {|in_file| in_file.gsub('.in', '.out')}
INS_AND_OUTS = IN_FILES.zip OUT_FILES

#
# Solution function
#
def solve(lines)
  num_tests = lines.shift.to_i

  solutions = []

  (0...num_tests).each do |i|
    seconds = lines.shift.strip
    chars = {}
    seconds.chars.each do |c|
      chars[c] = true
    end

    base = chars.length == 1 ? 2 : chars.length
    digits = (0...base).to_a
    mapping = {
      seconds[0] => digits[1]
    }
    digits.delete_at(1)

    seconds.chars.each do |c|
      next if mapping.has_key? c

      mapping[c] = digits.shift
    end

    base_10_seconds = 0
    seconds.reverse.chars.each_with_index do |c, i|
      base_10_seconds += mapping[c] * (base ** i)
    end

    solutions << base_10_seconds
  end

  solutions
end

#
# Boring garbage -- reads inputs, writes outputs, solving for each
#
INS_AND_OUTS.each do |in_and_out|
  in_path, out_path = in_and_out
  puts "Processing #{in_path}"

  out = open out_path, 'w' unless DEBUG

  open in_path do |file|
    solve(file.readlines).each_with_index do |solution, i|
      puts line = "Case ##{i + 1}: #{solution}\n"
      out.write line unless DEBUG
    end
  end

  out.close unless DEBUG
end