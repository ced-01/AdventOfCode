# frozen
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

directions = File.read("input.txt").strip
p count_houses(directions)