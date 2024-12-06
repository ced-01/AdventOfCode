# Récupération de l'input plus conversion en grille de jeu type: Tableau 2D avec coordonnées (y, x)
map = File.readlines("input.txt", chomp: true).map(&:chars)

# Définir les direction (Nord, Est, Sud, Ouest) => (y, x)

DIRECTIONS = {
  "^" => [-1, 0],
  ">" => [0, 1],
  "v" => [1, 0],
  "<" => [0, -1]
}

# Définir les rotations à droite quand obstacle

TURN_RIGHT = {
  "^" => ">",
  ">" => "v",
  "v" => "<",
  "<" => "^"
}

# Trouver la position inintiale et la direction du garde
guard_position = nil 
guard_direction = nil

map.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    if DIRECTIONS.keys.include?(cell)
      guard_position = [y, x]
      guard_direction = cell
    end
  end
end

# Ensemble des posiitons visitées
visited_positions = Set.new([guard_position])

# Simuler le mouvement
loop do
  # Calculer la position devant le garde
  dx, dy = DIRECTIONS[guard_direction]
  next_position = [guard_position[0] + dx, guard_position[1] + dy]

  # Vérifier si la position est hors de la carte
  if next_position[0] < 0 || next_position[0] >= map.size ||
      next_position[1] < 0 || next_position[1] >= map[0].size
      break
  end

  # Vérifier si la position devant est un obstacle
  if map[next_position[0]][next_position[1]] == "#"
    # Tourner à droite
    guard_direction = TURN_RIGHT[guard_direction]
  else
    # Avancer
    guard_position = next_position
    visited_positions.add(guard_position)
  end
end

# Afficher le nombre de positions visitées
puts "Nombre de positions distinctes visitées : #{visited_positions.size}"