require 'set'

# Charger la carte en matrice 2D
grid = File.readlines("input.txt", chomp: true).map(&:chars)

# Regrouper les antennes par fréquence
antennas_per_frequency = Hash.new { |hash, key| hash[key] = [] }

grid.each_with_index do |line, row|
  line.each_with_index do |cell, col|
    next if cell == "." # Ignorer les cellules vides
    antennas_per_frequency[cell] << [col, row] # Utilisation [x, y] pour correspondre au code fourni
  end
end

# Calcul des antinodes
antinodes = Set.new
direct_antinodes = Set.new

antennas_per_frequency.each do |_, antennas|
  antennas.each do |antenna1|
    antennas.each do |antenna2|
      next if antenna1 == antenna2 # Ignorer si c'est la même antenne

      x1, y1 = antenna1
      x2, y2 = antenna2

      # Ajouter les antennes elles-mêmes comme antinodes
      antinodes << [x1, y1]
      antinodes << [x2, y2]

      # Différences de coordonnées
      dx = x2 - x1
      dy = y2 - y1

      # Propagation vers l'extérieur à partir de chaque paire d'antennes
      i = 1
      loop do
        nx = x1 - i * dx
        ny = y1 - i * dy
        break unless nx >= 0 && ny >= 0 && nx < grid[0].size && ny < grid.size

        antinodes << [nx, ny]
        direct_antinodes << [nx, ny] if i == 1
        i += 1
      end

      i = 1
      loop do
        nx = x2 + i * dx
        ny = y2 + i * dy
        break unless nx >= 0 && ny >= 0 && nx < grid[0].size && ny < grid.size

        antinodes << [nx, ny]
        direct_antinodes << [nx, ny] if i == 1
        i += 1
      end
    end
  end
end

# Résultats
puts "Nombre total d'antinodes (Partie 2) : #{antinodes.size}"
puts "Nombre d'antinodes directs (Partie 1) : #{direct_antinodes.size}"
