lists = File.readlines("input.txt", chomp: true)

left_list = lists.map { |distance| distance[0..4].to_i }
right_list = lists.map { |distance| distance[8..12].to_i }

left_numeric_list =  left_list.sort
right_numeric_list = right_list.sort

result = 0
left_numeric_list.zip(right_numeric_list).each do |left_num, right_num|
  result += (left_num - right_num).abs
end

 p result