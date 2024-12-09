require 'set'

# Représentation de la carte en matrice 2D
grid = File.readlines("input.txt", chomp: true).map(&:chars)

# Regroupe les antennes par fréquence
antennas_per_frequency = Hash.new { |hash, key| hash[key] = [] }

grid.each_with_index do |line, row|
  line.each_with_index do |cell, col|
    next if cell == "." # Ignorer les cellules vides
    antennas_per_frequency[cell] << [row, col]
  end
end

# Calcul des antinodes
antinodes = Set.new

antennas_per_frequency.each do |frequency, antennas|
  antennas.each_with_index do |(row1, col1), index|
    antennas[index + 1..].each do |(row2, col2)|
      # Calcul des antinodes pour une paire d'antennes
      delta_row = row2 - row1
      delta_col = col2 - col1

      antinode1 = [row1 - delta_row, col1 - delta_col]
      antinode2 = [row2 + delta_row, col2 + delta_col]

      # Vérifier si les antinodes sont dans les limites
      [antinode1, antinode2].each do |row, col|
        next if row.negative? || col.negative? || row >= grid.size || col >= grid[0].size
        antinodes << [row, col]
      end
    end
  end
end

# Résultat final
puts "Nombre total d'antinodes uniques : #{antinodes.size}"
