# frozen_string_literal: true
#
# 1 - initialisation du hash 
# avec valeur par defaut égale 0 pour une clé non existante
# 2 - déclarartion des coordonnées de départ x => est/ouest 
# et y => nord/sud
# Soit pour chaque nouvelles coordonnées du hash[x, y],
# le hash retournera 0 et pour un hash[x, y] existant 
# on incremente sa valeur hash[x, y] += 1 cadeaux



def count_houses(directions)
  houses = Hash.new(0)
  x, y = 0, 0

  houses[[x, y]] += 1 # La maison de Départ reçoit un cadeau

  directions.each_char do |direction|
    case direction
    when "^" then y += 1
    when "v" then y -= 1
    when ">" then x += 1
    when "<" then x -= 1   
    end
    houses[[x, y]] += 1
  end
  visited_houses = houses.values.count{ |value| value >= 1 }
  visited_houses
end

def count_houses_with_robo(directions)
  # Hash pour stocker les maisons visitées
  houses = Hash.new(0)

  # Initialisation des positions pour Santa et Robo-Santa
  positions = { santa: [0, 0], robo: [0, 0] }

  # La maison de départ reçoit un cadeau
  houses[[0, 0]] += 1

  # Parcours des directions avec un cycle entre Santa et Robo-Santa
  directions.chars.each_with_index do |direction, index|
    actor = index.even? ? :santa : :robo

    # Mise à jour des coordonnées pour le livreur actif
    positions[actor] = move(positions[actor], direction)

    # Enregistrement de la maison visitée
    houses[positions[actor]] += 1
  end

  # Calcul du nombre de maisons visitées
  houses.keys.size
end

def move(position, direction)
  x, y = position
  case direction
  when "^" then [x, y + 1]
  when "v" then [x, y - 1]
  when ">" then [x + 1, y]
  when "<" then [x - 1, y]
  else [x, y] # Garde la même position si la direction est invalide
  end
end

# Lecture et appel de la méthode
directions = File.read("input.txt").strip
p count_houses_with_robo(directions)

