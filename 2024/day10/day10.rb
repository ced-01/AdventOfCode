require "set"

# Représenter la grille/carte
grid = File.readlines("input.txt", chomp: true).map { |line| line.chars.map(&:to_i) }

# Directions (haut, bas, gauche, droite)
DIRECTIONS = [[-1, 0], [1, 0], [0, -1], [0, 1]]

# Vérifier si une case est valide pour conitnuer le chemin.

def valid_next_case(x, y, current_value, grid, visited)
  n, m = grid.size, grid[0].size
  x_in_bounds = x >= 0 && x < m
  y_in_bounds = y >= 0 && y < n
  return false unless x_in_bounds && y_in_bounds
  return false if visited.include?([x, y])
  return false unless grid[y][x] == current_value + 1

  true
end

# Fonction pour explorer un chemin avec DFS (Depth-First Search)
def explore_trails(x, y, grid, visited)
  stack = [[x, y, grid[y][x]]]
  reachable_nine = 0

  until stack.empty?
    cx, cy, value = stack.pop
    next if visited.include?([cx, cy])

    visited.add([cx, cy])

    if value == 9
      reachable_nine += 1
      next
    end

    DIRECTIONS.each do |dx, dy|
      nx, ny = cx + dx, cy + dy
      if valid_next_case(nx, ny, value, grid, visited)
        stack.push([nx, ny, grid[ny][nx]])
      end
    end
  end

  reachable_nine
end

# Identifier les départs (cases 0) et calculer les scores
starting_points =[]
grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    # puts "coordonnées (#{x}, #{y}): #{cell}"
    starting_points << [x, y] if cell == 0
  end
end

# Calculer le score pour chaque point de départ
total_score = 0
starting_points.each do |x, y|
  visited = Set.new
  total_score += explore_trails(x, y, grid, visited)
end

puts "La somme des scores des points de départ est : #{total_score}"