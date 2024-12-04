input = File.readlines("input.txt", chomp: true)

# Grille d'entrée - liste de tableau imbriquée
def grid(input)
  input.map { |line| line.chars }
end
 
grid = grid(input)

  # Directions explicites
  DIRECTIONS = [
    [1, 0],    # droite
    [-1, 0],   # gauche
    [0, 1],    # bas
    [0, -1],   # haut
    [1, 1],    # diagonale bas-droite
    [-1, -1],  # diagonale haut-gauche
    [1, -1],   # diagonale bas-gauche
    [-1, 1]    # diagonale haut-droite
  ]

def count_xmas_occurrences(grid)
  rows = grid.size       # Nombre de lignes
  cols = grid.first.size # Nombre de colonnes
  word = ["X", "M", "A", "S"] # Le mot cible
  word_length = word.size
  count = 0              # Compteur d'occurrences


  # Parcourir chaque position de la grille
  (0...rows).each do |start_x|
    (0...cols).each do |start_y|
      # Vérifier pour chaque direction
      DIRECTIONS.each do |dx, dy|
        valid = true

        # Initialiser la position actuelle
        current_x = start_x
        current_y = start_y

        word.each do |char|
          # Vérifier les limites et la correspondance
          if current_x < 0 || current_x >= rows || current_y < 0 || current_y >= cols || grid[current_x][current_y] != char
            valid = false
            break
          end

          # Avancer d'une case dans la direction actuelle
          current_x += dx
          current_y += dy
        end

        # Si le mot est valide dans cette direction, incrémenter le compteur
        count += 1 if valid
      end
    end
  end

  count
end



p count_xmas_occurrences(grid)

