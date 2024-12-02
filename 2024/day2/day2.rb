reports = File.readlines("input.txt", chomp: true)

reports_num = reports.map { |report| report.split.map(&:to_i)}

valid_reports_adjacents = []

reports_num.each do |report| 
  is_valid = report.each_cons(2).all? { |a, b| (a - b).abs <= 3}
  valid_reports_adjacents << report if is_valid
end

valid_reports = []

valid_reports_adjacents.each do |report|
    is_increasing = report.each_cons(2).all? { |a, b| a > b }
    is_decreasing = report.each_cons(2).all? { |a, b| a < b }
    
    valid_reports << report if is_increasing || is_decreasing
end

puts " valids reports part_1 / Day2 : #{valid_reports.length}"

