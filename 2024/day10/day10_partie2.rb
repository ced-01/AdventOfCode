require "set"

# Représenter la grille/carte
grid = File.readlines("input.txt", chomp: true).map { |line| line.chars.map(&:to_i) }

# Directions (haut, bas, gauche, droite)
DIRECTIONS = [[-1, 0], [1, 0], [0, -1], [0, 1]]

# Fonction récursive pour explorer les chemins distincts
def explore_paths(x, y, current_value, grid, path)
  n, m = grid.size, grid[0].size
  return 0 if x < 0 || x >= m || y < 0 || y >= n # Hors de la grille
  return 0 if grid[y][x] != current_value + 1    # Valeur incorrecte
  return 1 if grid[y][x] == 9                   # Chemin valide terminé

  # Ajouter la position actuelle au chemin
  path.add([x, y])

  total_paths = 0
  DIRECTIONS.each do |dx, dy|
    nx, ny = x + dx, y + dy
    # Si la prochaine case n'est pas déjà dans le chemin, explorer
    unless path.include?([nx, ny])
      total_paths += explore_paths(nx, ny, grid[y][x], grid, path.dup)
    end
  end

  total_paths
end

# Identifier les départs (cases 0)
starting_points = []
grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    starting_points << [x, y] if cell == 0
  end
end

# Calculer les ratings pour chaque point de départ
total_rating = 0
starting_points.each do |x, y|
  # Explorer tous les chemins depuis chaque point de départ
  total_rating += explore_paths(x, y, -1, grid, Set.new)
end

puts "La somme des notes des points de départ est : #{total_rating}"