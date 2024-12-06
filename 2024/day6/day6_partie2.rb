grid = File.readlines("input.txt", chomp: true)

##### Part 2
IMAX = grid.length - 1
JMAX = grid[0].length - 1
TURNS = {
  "^" => ">",
  ">" => "v",
  "v" => "<",
  "<" => "^"
}

# state = [leaving, position, direction, collision]
def main_loop(grid, unique_positions = nil)
  state = init_state(grid)
  collisions = []
  leaving = state[0]

  until leaving
    state = next_state(grid, state, unique_positions)
    leaving, position, direction, collision = state
    # if an identical collision has been encountered before, we are in an infinite loop
    return true if collisions.include?(collision)

    collisions << collision unless collision.nil?
    leaving = state[0]
  end

  unique_positions << key(state[1][0], state[1][1]) unless unique_positions.nil? || unique_positions.include?(key(state[1][0], state[1][1]))
  return false
end

def init_state(grid)
  (0..IMAX).each do |i|
    (0..JMAX).each do |j|
      return [false, [i,j], grid[i][j]] if %w(^ v < >).include?(grid[i][j])
    end
  end
end

def next_state(grid, state, unique_positions = nil)
  position = state[1]
  direction = state[2]
  i,j = position
  u,v = next_position(i,j,direction)

  while true
    unique_positions << key(i,j) unless unique_positions.nil? || unique_positions.include?(key(i,j))
    if grid[u][v] == "#"
      return [false, [i,j], TURNS[direction], key(i,j,direction)]
    elsif u == 0 || u == IMAX || v == 0 || v == JMAX
      return [true, [u,v], direction, nil]
    end

    i,j = [u,v]
    u,v = next_position(i,j,direction)
  end
end

def next_position(i, j, direction)
  return [i-1,j] if direction == "^"
  return [i+1,j] if direction == "v"
  return [i,j-1] if direction == "<"
  return [i,j+1] if direction == ">"
end

def key(i, j, direction = nil)
  return "#{i}_#{j}" if direction.nil?

  "#{i}_#{j}_#{direction}"
end

unique_positions = []
main_loop(grid, unique_positions)
good_obstacles = []

# For possible obstacles, only test unique_positions (since the other positions are not visited, they cannot trigger an infinite loop)
unique_positions.each.with_index do |position, index|
  print "\rTesting position ##{index}/#{unique_positions.count}"
  i,j = position.split("_").map(&:to_i)
  next if %w(^ v < >).include?(grid[i][j]) || grid[i][j] == "#"

  clone = grid.clone.map(&:clone)
  clone[i][j] = "#"
  infinite_loop = main_loop(clone)
  good_obstacles << [i,j] if infinite_loop
end

puts
puts "#{good_obstacles.count} possible obstacle positions"
