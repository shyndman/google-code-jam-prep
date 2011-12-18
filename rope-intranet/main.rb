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

  (0...num_tests).each do |test|
    num_wires = lines.shift.to_i
    wires = []

    (0...num_wires).each do |j|
      wires << lines.shift.split(' ').map {|e| e.to_i }
    end

    crosses = 0
    (0...num_wires).each do |i|
      ((i + 1)...num_wires).each do |j|
        wire1 = wires[i]
        wire2 = wires[j]

        crosses += 1 if (
          (wire1[0] > wire2[0] && wire1[1] < wire2[1]) ||
          (wire1[0] < wire2[0] && wire1[1] > wire2[1]))
      end
    end

    solutions << crosses
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