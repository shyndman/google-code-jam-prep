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
  word_length, num_known_words, num_received = lines.shift.split(' ').map { |e| e.to_i }
  known_words = []

  (0...num_known_words).each do |i|
    known_words << lines.shift.strip
  end

  solutions = []

  (0...num_received).each do |i|
    signal = lines.shift.strip
    signal.gsub!(/\([^\)]+\)/) do |match|
      "(#{match[1...-1].split('').join('|')})"
    end

    solutions << known_words.select { |word| !!word.match(signal) }.length
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