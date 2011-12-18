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
  num_cases = lines.shift.to_i

  solutions = []

  (0...num_cases).each do |test|
    num_existing, num_create = lines.shift.split(' ').map {|ele| ele.to_i}
    existing_dirs = { '/' => true }

    (0...num_existing).each do |test|
      existing = lines.shift.strip
      inc = ''
      existing.split('/').each do |part|
        inc += part + '/'
        existing_dirs[inc] = true
      end
    end

    create_cnt = 0

    (0...num_create).each do |test|
      to_create = lines.shift.strip

      inc = ''
      to_create.split('/').each do |part|
        inc += part + '/'
        unless existing_dirs.has_key? inc
          create_cnt += 1
          existing_dirs[inc] = true
        end
      end
    end

    solutions << create_cnt
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