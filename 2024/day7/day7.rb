# Supprimes les ":" / Sépare les nombres par les " " / Convertis en integer
equations = File.readlines("input.txt", chomp: true).map do |equation|
  equation.delete(":").split.map(&:to_i)
end

# Séparation des résultats et nombres à traiter. L'index est également le n° de l'équation
equations_results = []
equations_numbers = []

equations.map do |equation|
  equations_results << equation.shift
  equations_numbers << equation
end

# Initialisation des variables
total_calibration =  0
good_equations = []
bad_equations = []

# Combinaisons possible des opérateurs entre les nombres
operators = [:+, :*]

# Fonction pour évaluer les combinaisons d'opérateurs
def evaluate_with_operators(numbers, operators)
  result = numbers.first
  numbers[1..].each_with_index do |num, index|
    result = result.send(operators[index], num)
  end
  result
end

# Parcours de chaque équation
equations_numbers.each_with_index do |numbers, index|
  target = equations_results[index]

  # Générer toutes les combinaisons d'opérateurs pour cette équation
  num_operators = numbers.size - 1
  operator_combinations = operators.repeated_permutation(num_operators)

  # Vérifier si une combinaison d'opérateurs donne le résultat attendu
  is_valid = false
  operator_combinations.each do |operator_set|
    result = evaluate_with_operators(numbers, operator_set)
    if result == target
      total_calibration += target
      good_equations << { index: index, target: target, operators: operator_set }
      is_valid = true
      break # Sortir dès qu'une combinaison fonctionne
    end
  end

  bad_equations << { index: index, target: target } unless is_valid
end

# Affichage des résultats
puts "Total calibration result: #{total_calibration}"
puts "Valid equations: #{good_equations.size}"
puts "Invalid equations: #{bad_equations.size}"