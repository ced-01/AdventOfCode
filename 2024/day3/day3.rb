input = File.readlines("input.txt", chomp: true)


def multiply_and_sum(active_inputs)
  numbers = active_inputs.scan(/mul\((\d+),(\d+)\)/).map do |match| match.map(&:to_i)
  end

  numbers.sum { |num1, num2| num1 * num2 }
end

# input en une seule string
corrupt_input = input.join

# Détection du premier don't() pour récupération du texte actif par default
first_active_inputs = corrupt_input.split("don't()").first

# Détection du texte entre les do() et les don't() VERIFIER SI .JOIN EST OKKKKK
second_active_inputs = corrupt_input.scan(/do\(\)(.*?)don't\(\)/m).join

# Détection du dernier do() car si pas de don't() le texte actif ne sera pas détecté par second_active_inputs
last_active_inputs = corrupt_input.split("do()").last

# Sum de tous les nombres/textes actifs
first_total_sum = multiply_and_sum(first_active_inputs)
second_total_sum = multiply_and_sum(second_active_inputs)
last_total_sum = multiply_and_sum(last_active_inputs)

# Total
p total_sum = first_total_sum + second_total_sum + last_total_sum 


# Partie 1 - day3 -2024
# # Extraction des motifs "mul(x, y)" avec leurs valeurs
# valid_inputs = corrupt_inputs.flat_map { |line| 
#   line.scan(/mul\((\d+),(\d+)\)/).map { |match| match.map(&:to_i) } 
# }

# # Initialisation de la somme totale
# total_sum = 0

# # Traitement des paires de nombres et calcul de la somme totale
# valid_input.each do |num1, num2|
#   total_sum += num1 * num2
# end

# p total_sum
